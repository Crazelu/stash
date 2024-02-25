//
//  Contact.swift
//  Stash
//
//  Created by LUCKY EBERE on 25/02/2024.
//

import Foundation
import SwiftData

@Model
final class Contact: Identifiable {
  @Attribute(.unique) var id: String
  var phoneNumber: String
  var firstName: String
  var lastName: String
  var blocked: Bool


  init(id: String, phoneNumber: String, firstName: String, lastName: String, blocked: Bool) {
    self.phoneNumber = phoneNumber
    self.firstName = firstName
    self.lastName = lastName
    self.blocked = blocked
    self.id = id
  }


  init(phoneNumber: String, firstName: String, lastName: String, blocked: Bool) {
    self.phoneNumber = phoneNumber
    self.firstName = firstName
    self.lastName = lastName
    self.blocked = blocked
    self.id = UUID().uuidString
  }

  init(phoneNumber: String, firstName: String, lastName: String) {
    self.phoneNumber = phoneNumber
    self.firstName = firstName
    self.lastName = lastName
    self.blocked = false
    self.id = UUID().uuidString
  }

  init(phoneNumber: String, firstName: String){
    self.phoneNumber = phoneNumber
    self.firstName = firstName
    self.lastName = ""
    self.blocked = false
    self.id = UUID().uuidString
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
