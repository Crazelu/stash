//
//  ContactRow.swift
//  Stash
//
//  Created by LUCKY EBERE on 25/02/2024.
//

import SwiftUI

struct ContactRow: View {
  let contact: Contact
  let onRowTapped: () -> Void
  let onEdit: () -> Void

  @EnvironmentObject private var contactVM: ContactViewModel

    var body: some View {
      Button(action: onRowTapped) {
        HStack {
          Text(contact.firstCharacter)
            .font(.title3)
            .fontWeight(.bold)
            .frame(width: 30, height: 30)
            .padding(.all, 10)
            .background(AppConstants.Colors.gray)
            .foregroundColor(.white)
            .cornerRadius(50)
            .padding(.trailing, 4)

          Text(contact.name)
            .font(.title3)
          Spacer()
          NavigationLink {
            ContactDetailsView(contact: contact)
          } label: {
            Image(systemName: "info.circle")
              .resizable()
              .frame(width: 20, height: 20)
              .foregroundColor(.blue)
          }

        }
        .padding(.horizontal, 16)
      }
      .tint(AppConstants.Colors.textColor)
      .contextMenu(ContextMenu(menuItems: {
        ContextMenuItem(text: "Call", image: "phone", action: {contactVM.call(contact: contact)})
        ContextMenuItem(text: "Message", image: "message", action: {contactVM.sendMessage(to: contact)})
        ContextMenuItem(text: "Copy", image: "doc.on.doc", action: {contactVM.copy(contact: contact)})
        ContextMenuItem(text: "Edit", image: "square.and.pencil", action: {onEdit()})
        ContextMenuItem(text: "Delete Contact", image: "trash", action: {contactVM.deleteContact(contact: contact)}, role: .destructive)
      }))
    }
}

#Preview {
  ContactRow(
    contact: Contact.contacts.first!,
    onRowTapped: {},
    onEdit: {}
  )
    .preferredColorScheme(.dark)
}
