//
//  ContactViewModel.swift
//  Stash
//
//  Created by LUCKY EBERE on 25/02/2024.
//

import Foundation
import SwiftUI
import SwiftData
import CallKit

class ContactViewModel: ObservableObject {
  let callDirectoryID = "com.devcrazelu.Stash.CallDirectoryExtension"
  let dataStore = DataStore()

  let persistantContainer: ModelContainer

  init() {
    do {
      persistantContainer = try ModelContainer(
        for: Contact.self,
        configurations: ModelConfiguration(for: Contact.self)
      )
    } catch {
      fatalError("Could not initialize ModelContainer")
    }
  }

  @Published var contacts: [Contact] = []

  func checkCallDirectoryExtensionStatus(onDisabled: @escaping () -> Void)  {
    CXCallDirectoryManager.sharedInstance.getEnabledStatusForExtension(withIdentifier: callDirectoryID) {
      status, error in
      if let error = error {
        debugPrint("ERROR FROM getEnabledStatusForExtension: \(error)")
      }
      if (status.rawValue != 2) {
        onDisabled()
      }
    }
  }

  func goToSettings() {
    CXCallDirectoryManager.sharedInstance.openSettings { error in
      if let error = error {
        debugPrint("ERROR FROM openSettings: \(error)")
      }
    }
  }

  @MainActor func getContacts() {    do {
      let predicate = #Predicate<Contact> { object in
        !object.phoneNumber.isEmpty
      }
      let descriptor = FetchDescriptor(predicate: predicate)
      contacts = try persistantContainer.mainContext.fetch(descriptor)
      sortContacts()
      reloadCallDirectory()
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
    guard let url = URL(string: "tel:+\(number)") else { return }
    UIApplication.shared.open(url)
  }

  func reloadCallDirectory() {
    CXCallDirectoryManager.sharedInstance.reloadExtension(
      withIdentifier: callDirectoryID, completionHandler: { (error) in
        if let error = error {
          debugPrint("Error from reloadExtension: \(error)")
        } else {
          debugPrint("Reloaded extension")
        }
      })
  }

  @MainActor func addNewContact(contact: Contact) {
    do {
      persistantContainer.mainContext.insert(contact)
      try persistantContainer.mainContext.save()
      dataStore.addContact(contact: contact)
      reloadCallDirectory()
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
      dataStore.deleteContact(id: contact.id)
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

  @MainActor func deleteContact(contact: Contact) {
    do {
      persistantContainer.mainContext.delete(contact)
      try persistantContainer.mainContext.save()
      dataStore.deleteContact(id: contact.id)
      reloadCallDirectory()
    } catch {
      debugPrint("Error from delete: \(error)")
    }
    getContacts()
  }

  func sendMessage(to contact: Contact) {
    guard let url = URL(string: "sms:+\(contact.phoneNumber)") else { return }
    UIApplication.shared.open(url)
  }

  func copy(contact: Contact) {
    UIPasteboard.general.string = "+\(contact.phoneNumber)"
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
