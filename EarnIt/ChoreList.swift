//
//  ContentView.swift
//  EarnIt
//
//  Created by Ryan Jones on 10/5/20.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      VStack {
        if #available(iOS 14.0, *) {
          List {
            // Content goes here
          }
          .listStyle(InsetGroupedListStyle())
        } else {
          List {
            // Content goes here
          }
          .listStyle(GroupedListStyle())
        }
      }
      .navigationBarTitle(Text("Chores"))
      .navigationBarItems(trailing:
        HStack {
          VStack {
            Button(action: {}) {
              Image(systemName: "envelope")
            }
            .padding(.horizontal, 30.0)
          }
          VStack {
            Button(action: {}) {
              Image(systemName: "plus")
            }
          }
        }
      )
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
