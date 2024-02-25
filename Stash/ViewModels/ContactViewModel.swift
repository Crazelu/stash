//
//  ContactViewModel.swift
//  Stash
//
//  Created by LUCKY EBERE on 25/02/2024.
//

import Foundation
import SwiftUI

class ContactViewModel: ObservableObject {
  @Published var contacts: [Contact] = []

  func getContacts() {
    contacts = Contact.contacts
    sortContacts()
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

  func addNewContact(contact: Contact) {
    contacts.append(contact)
    sortContacts()
  }

  func editContact(for id: UUID, contact: Contact) {
    contacts.removeAll { c in
      id == c.id
    }
    addNewContact(contact: contact)
  }

  func deleteContact(at offset: IndexSet) {
    contacts.remove(atOffsets: offset)
  }

  func delete(contact: Contact) {
    contacts.removeAll { c in
      contact.id == c.id
    }
  }

  func sendMessage(to contact: Contact) {
    guard let url = URL(string: "sms:\(contact.phoneNumber)") else { return }
    UIApplication.shared.open(url)
  }

  func copy(contact: Contact) {
    UIPasteboard.general.string = contact.phoneNumber
  }

  func block(contact: Contact) {
    
  }
}
