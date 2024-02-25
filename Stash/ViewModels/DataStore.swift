//
//  CoreDataStore.swift
//  Stash
//
//  Created by LUCKY EBERE on 25/02/2024.
//

import Foundation

class DataStore {

  private let contactsKey: String
  let userDefaults: UserDefaults

   init() {
     guard let filePath = Bundle.main.path(forResource: "Keys", ofType: "plist") else {
       userDefaults = UserDefaults.standard
       contactsKey = "DEFAULT"
       return
     }

     let plist = NSDictionary(contentsOfFile: filePath)

     guard let suiteName = plist?.object(forKey: "GROUP_ID") as? String else {
       contactsKey = "DEFAULT"
       userDefaults = UserDefaults.standard
       return
     }

     guard let key = plist?.object(forKey: "DATA_KEY") as? String else {
       contactsKey = "DEFAULT"
       userDefaults = UserDefaults.standard
       return
     }
     contactsKey = key

     if let defaults = UserDefaults(suiteName: suiteName) {
       userDefaults = defaults
     } else {
       userDefaults = UserDefaults.standard
     }
  }

  private var contacts: [ContactEntity] = []

  private func save() {
    let data = contacts.compactMap { $0.map }
    userDefaults.setValue(data, forKey: contactsKey)
  }

   func getContacts() -> [ContactEntity] {
     let data = userDefaults.value(forKey: contactsKey) as? [[String:Any]] ?? []
     contacts = data.compactMap { map in
       ContactEntity(map: map)
     }
     return contacts
   }

  func addContact(contact: Contact) {
    contacts = getContacts()
    contacts.append(ContactEntity(map: contact.map))
    save()
  }

  func deleteContact(id: String) {
    contacts = getContacts()
    contacts.removeAll { $0.id == id }
    save()
  }

  private func sortContacts() -> [ContactEntity] {
    contacts = getContacts()
    contacts = contacts.sorted(by: { a, b in
       return b.phoneNumber > a.phoneNumber
     })
    return contacts
  }

   func getPhoneNumbers() -> [Int64] {
     sortContacts().filter({ !$0.blocked }).compactMap { Int64($0.phoneNumber) }
  }

   func getLabels () -> [String] {
    return sortContacts().filter({ !$0.blocked })
       .compactMap { "\($0.firstName) \($0.lastName)".trimmingCharacters(in: .whitespaces) }
  }

   func getBlockedPhoneNumbers() -> [Int64] {
     var contacts = sortContacts()
     contacts = contacts.filter({ $0.blocked })

     return contacts.compactMap { Int64($0.phoneNumber) }
  }

}
