//
//  EarnItApp.swift
//  EarnIt
//
//  Created by Ryan Jones on 10/5/20.
//

import SwiftUI

@main
struct EarnItApp: App {
  let context = DataStore.shared.persistentContainer.viewContext
  var body: some Scene {
    WindowGroup {
      ContentView().environment(\.managedObjectContext, context)
    }
  }
}
