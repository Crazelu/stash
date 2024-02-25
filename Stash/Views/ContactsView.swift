//
//  ContactsView.swift
//  Stash
//
//  Created by LUCKY EBERE on 25/02/2024.
//

import SwiftUI

struct ContactsView: View {
  @EnvironmentObject private var contactVM: ContactViewModel
  @State private var isNewContactSheetVisible = false
  @State private var isEditContactSheetVisible = false
  @State private var contactToEdit: Contact? = nil
  @State private var isExtensionStatusAlertVisible = false

  var body: some View {
    NavigationView {
      ScrollView {
        if(contactVM.contacts.isEmpty) {
          Text("It's super quiet in here 🙈")
            .font(.headline)
            .padding(.top, 250)
            .padding(.bottom, 8)
          Button(action: {isNewContactSheetVisible.toggle()}) {
            Text("Add a contact")
              .padding(12)
              .background(Color.blue)
              .foregroundColor(.white)
              .cornerRadius(8)
          }
        }
        else {
          LazyVStack {
            ForEach(contactVM.contacts, id: \.id) { contact in
              ContactRow(contact: contact, onRowTapped: {
                contactVM.callNumber(number: contact.phoneNumber)
              }, onEdit: {
                contactToEdit = contact
                isEditContactSheetVisible.toggle()
              }
              )

            }
          }
          .padding(.top)
        }
      }
      .navigationTitle("Stash🗂️")
      .sheet(isPresented: $isNewContactSheetVisible) {
        NewContactView { contact in
          contactVM.addNewContact(contact: contact)
        }
      }.sheet(isPresented: $isEditContactSheetVisible) {
        EditContactView(contact: $contactToEdit) { editedContact in
          contactVM.editContact(contact: editedContact)
        }
      }
      .alert(isPresented: $isExtensionStatusAlertVisible, content: {
        Alert(
          title: Text("Call Directory Extension Disabled"),
          message: Text("Open settings, click on Call Blocking & Identification and enable Stash from the list of Call Identification Apps"),
          primaryButton: .default(Text("Enable"), action: {
            contactVM.goToSettings()
          }),
          secondaryButton: .cancel()
        )
      })
      .toolbar {
        if(!contactVM.contacts.isEmpty) {
          Button(action: {isNewContactSheetVisible.toggle()}) {
            Image(systemName: "plus")
          }
        }
      }
    }
    .onAppear {
      contactVM.getContacts()
      contactVM.checkCallDirectoryExtensionStatus {
        isExtensionStatusAlertVisible.toggle()
      }
    }
  }
}

#Preview {
  ContactsView()
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
