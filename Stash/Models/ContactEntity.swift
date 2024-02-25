//
//  ContactEntity.swift
//  Stash
//
//  Created by LUCKY EBERE on 25/02/2024.
//

import Foundation

struct ContactEntity {
  var id: String
  var phoneNumber: String
  var firstName: String
  var lastName: String
  var blocked: Bool

  init(map: [String:Any]) {
    self.phoneNumber = map["phoneNumber"] as? String ?? ""
    self.firstName = map["firstName"] as? String ?? ""
    self.lastName = map["lastName"] as? String ?? ""
    self.blocked = map["blocked"] as? Bool ?? false
    self.id = map["id"] as? String ?? ""
  }

  var map: [String: Any] {
    return [
      "id": id,
      "phoneNumber": phoneNumber,
      "firstName": firstName,
      "lastName": lastName,
      "blocked": blocked
    ]
  }
}
