//
//  EditContactView.swift
//  Stash
//
//  Created by LUCKY EBERE on 25/02/2024.
//

import SwiftUI

struct EditContactView: View {

  let contact: Binding<Contact?>
  let onEdit: (Contact) -> Void

  @Environment(\.dismiss) var dismiss
  @State private var firstName = ""
  @State private var lastName = ""
  @State private var phoneNumber = ""

  var buttonDisabled: Bool {
    firstName == contact.wrappedValue!.firstName &&
    phoneNumber == contact.wrappedValue!.phoneNumber
    && lastName == contact.wrappedValue!.lastName
  }

  var body: some View {
    VStack {
      HStack {
        Button("Cancel") {
          dismiss()
        }
        Spacer()
        Text("Edit Contact")
          .fontWeight(.semibold)
        Spacer()
        Button("Done") {
          onEdit(
            Contact(
              id: contact.wrappedValue!.id,
              phoneNumber: phoneNumber,
              firstName: firstName,
              lastName: lastName,
              blocked: contact.wrappedValue!.blocked
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
          TextField("Phone number", text: $phoneNumber)
            .keyboardType(.numberPad)
        }
      }
    }
    .onAppear {
      firstName = contact.wrappedValue!.firstName
      lastName = contact.wrappedValue!.lastName
      phoneNumber = contact.wrappedValue!.phoneNumber
    }
  }
}

#Preview {
  EditContactView(
    contact: .constant(Contact.contacts.first!),
    onEdit: {contact in }
  )
  .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
