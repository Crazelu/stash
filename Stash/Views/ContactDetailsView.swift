//
//  ContactDetailsView.swift
//  Stash
//
//  Created by LUCKY EBERE on 25/02/2024.
//

import SwiftUI

struct ContactDetailsView: View {
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject private var contactVM: ContactViewModel
  @State private var isEditContactSheetVisible = false
  @State private var contactToEdit: Contact? = nil

  let contact: Contact

  var body: some View {
    GeometryReader { proxy in
      ScrollView {
        LazyVStack(alignment: .leading) {
          VStack {
            Text(contact.firstCharacter)
              .font(.system(size: 60))
              .fontWeight(.bold)
              .frame(width: 200, height: 200)
              .background(Color.gray)
              .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
              .padding(.bottom, 12)
            Text(contact.name)
              .font(.title3)
              .padding(.bottom, 12)
            HStack {
              ActionItem(
                action: {contactVM.call(contact: contact)},
                text: "call",
                image: "phone.fill"
              )
              ActionItem(
                action: {contactVM.sendMessage(to: contact)},
                text: "message",
                image: "message.fill"
              )
              ActionItem(
                action: {contactVM.copy(contact: contact)},
                text: "copy",
                image: "doc.on.doc"
              )
            }
          }
          .frame(width: proxy.size.width)
          .padding(.bottom, 20)

          Button(action: {
            contactVM.call(contact: contact)
          }) {
            VStack(alignment: .leading) {
              Text("mobile")
                .foregroundStyle(Color(AppConstants.Colors.textColor))
              Text(contact.phoneNumber)
                .foregroundStyle(.blue)
            }
            .frame(width: proxy.size.width * 0.9, alignment: .leading)
            .padding(12)
            .background(AppConstants.Colors.gray)
            .cornerRadius(8)
          }
          .padding(.horizontal, 8)

          Button(role: .destructive) {
            contactVM.block(contact: contact)
          } label: {
            Text("\(contact.blocked ? "Unblock" : "Block") this Caller")
              .frame(width: proxy.size.width * 0.9, alignment: .leading)
              .padding(12)
              .background(AppConstants.Colors.gray)
              .cornerRadius(8)
          }
          .padding(.horizontal, 8)
        }
      }
      .navigationBarBackButtonHidden(true)
      .navigationBarItems(
        leading: Button(action: {dismiss()}) {
          Image(systemName: "chevron.left")
            .frame(width: 40, height: 40)
            .background(AppConstants.Colors.gray)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        },
        trailing:Button(action: { 
          contactToEdit = contact
          isEditContactSheetVisible.toggle()
        }) {
          Text("Edit")
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(AppConstants.Colors.gray)
            .cornerRadius(20)
        }
      ) .tint(.white)
        .sheet(isPresented: $isEditContactSheetVisible) {
          EditContactView(contact: $contactToEdit) { editedContact in
            contactVM.editContact(contact: editedContact)
          }
        }
    }
  }
}

struct ActionItem: View {
  let action: () -> Void
  let text: String
  let image: String

  var body: some View {
    Button(action: action) {
      VStack {
        Image(systemName: image)
          .padding(.bottom, 2)
        Text(text)
          .font(.caption)
      }
      .frame(width: 60, height: 40)
      .padding(.horizontal, 16)
      .padding(.vertical, 8)
      .background(AppConstants.Colors.gray)
      .cornerRadius(8)
    }
  }
}

#Preview {
  ContactDetailsView(contact: Contact.contacts.first!)
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
