//
//  Contact.swift
//  Stash
//
//  Created by LUCKY EBERE on 25/02/2024.
//

import Foundation

struct Contact: Identifiable {
  let id = UUID()
  var phoneNumber: String
  var firstName: String
  var lastName: String

  init(phoneNumber: String, firstName: String, lastName: String) {
    self.phoneNumber = phoneNumber
    self.firstName = firstName
    self.lastName = lastName
  }

  init(phoneNumber: String, firstName: String){
    self.phoneNumber = phoneNumber
    self.firstName = firstName
    self.lastName = ""
  }

  var name: String {
    "\(firstName) \(lastName)"
  }

  var firstCharacter: String {
    name.first?.uppercased() ?? ""
  }

  static let contacts: [Contact] = [
    Contact(phoneNumber: "07069423448", firstName: "Lucky", lastName: "Ebere"),
    Contact(phoneNumber: "08060016745", firstName: "Daddy")
  ]
}
