//
//  ContentView.swift
//  Stash
//
//  Created by LUCKY EBERE on 25/02/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ContactsView()
    }
}

#Preview {
    ContentView()
    .environmentObject(ContactViewModel())
    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
