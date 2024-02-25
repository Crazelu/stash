//
//  ContextMenuItem.swift
//  Stash
//
//  Created by LUCKY EBERE on 25/02/2024.
//

import SwiftUI

struct ContextMenuItem: View {
  let text: String
  let image: String
  let action: () -> Void
  let role: ButtonRole?

  init(text: String, image: String, action: @escaping () -> Void) {
    self.text = text
    self.image = image
    self.action = action
    self.role = nil
  }

  init(text: String, image: String, action: @escaping () -> Void, role: ButtonRole) {
    self.text = text
    self.image = image
    self.action = action
    self.role = role
  }

  var body: some View {
    Button(role: role) {
      action()
    }
  label: {
    HStack {
      Text(text)
      Image(systemName: image)
    }
  }
  }
}

#Preview {
  ContextMenuItem(text: "Message", image: "phone", action: {})
}
