//
//  NewContactView.swift
//  Stash
//
//  Created by LUCKY EBERE on 25/02/2024.
//

import SwiftUI

struct NewContactView: View {

  let onDone: (Contact) -> Void

  @Environment(\.dismiss) var dismiss
  @State private var firstName = ""
  @State private var lastName = ""
  @State private var phoneNumber = ""

  var buttonDisabled: Bool {
    firstName.isEmpty || phoneNumber.isEmpty
  }

  var body: some View {
    VStack {
      HStack {
        Button("Cancel") {
          dismiss()
        }
        Spacer()
        Text("New Contact")
          .fontWeight(.semibold)
        Spacer()
        Button("Done") {
          onDone(
            Contact(
              phoneNumber: phoneNumber,
              firstName: firstName,
              lastName: lastName
            )
          )
          dismiss()
        }
        .disabled(buttonDisabled)
      }
      .padding(.top, 16)
      .padding(.horizontal)
      Form {
        Section {
          TextField("First name", text: $firstName)
          TextField("Last name", text: $lastName)
          TextField("Phone number (with country code)", text: $phoneNumber)
            .keyboardType(.numberPad)
        }
      }
    }
  }
}

#Preview {
  NewContactView(onDone: { contact in

  })
  .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
