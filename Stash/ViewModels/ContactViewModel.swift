//
//  ContactViewModel.swift
//  Stash
//
//  Created by LUCKY EBERE on 25/02/2024.
//

import Foundation
import SwiftUI
import SwiftData

class ContactViewModel: ObservableObject {
  let persistantContainer: ModelContainer = {
    do {
      let container = try ModelContainer(
        for: Contact.self,
        configurations: ModelConfiguration(for: Contact.self)
      )
      return container
    } catch {
      fatalError("Failed to create a container")
    }
  }()

  @Published var contacts: [Contact] = []

  @MainActor func getContacts() {
    do {
      let predicate = #Predicate<Contact> { object in
        !object.phoneNumber.isEmpty
      }
      let descriptor = FetchDescriptor(predicate: predicate)
      let object = try persistantContainer.mainContext.fetch(descriptor)
      contacts = object
      sortContacts()
    } catch {
      debugPrint("Error from getContacts: \(error)")
      return
    }

  }

  func sortContacts() {
    contacts = contacts.sorted { a, b in
      b.name > a.name
    }
  }

  func call(contact: Contact) {
    callNumber(number: contact.phoneNumber)
  }

  func callNumber(number: String) {
    guard let url = URL(string: "tel:\(number)") else { return }
    UIApplication.shared.open(url)
  }

  @MainActor func addNewContact(contact: Contact) {
    do {
      persistantContainer.mainContext.insert(contact)
      try persistantContainer.mainContext.save()
    } catch {
      debugPrint("Error from addNewContact: \(error)")
    }
    getContacts()
  }

  func getContact(with id: String) throws -> Contact? {
    return contacts.first { contact in
      contact.id == id
    }
  }

  @MainActor func editContact(contact: Contact) {
    do {
      guard let oldContact = try getContact(with: contact.id) else {
        debugPrint("Couldn't find contact for \(contact.id)")
        return
      }
      persistantContainer.mainContext.delete(oldContact)
      try persistantContainer.mainContext.save()
      addNewContact(
        contact: Contact(
            id: contact.id,
            phoneNumber: contact.phoneNumber,
            firstName: contact.firstName,
            lastName: contact.lastName,
            blocked: contact.blocked
          )
      )
    } catch {
      debugPrint("Error from editContact: \(error)")
    }
  }

  @MainActor func delete(contact: Contact) {
    persistantContainer.mainContext.delete(contact)
    do {
      try persistantContainer.mainContext.save()
    } catch {
      debugPrint("Error from delete: \(error)")
    }
    getContacts()
  }

  func sendMessage(to contact: Contact) {
    guard let url = URL(string: "sms:\(contact.phoneNumber)") else { return }
    UIApplication.shared.open(url)
  }

  func copy(contact: Contact) {
    UIPasteboard.general.string = contact.phoneNumber
  }

  @MainActor func block(contact: Contact) {
    editContact(
      contact: Contact(
        id: contact.id,
        phoneNumber: contact.phoneNumber,
        firstName: contact.firstName,
        lastName: contact.lastName,
        blocked: !contact.blocked
      )
    )
  }
}
