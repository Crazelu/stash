//
//  StashApp.swift
//  Stash
//
//  Created by LUCKY EBERE on 25/02/2024.
//

import SwiftUI
import SwiftData

@main
struct StashApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(ContactViewModel())
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}
