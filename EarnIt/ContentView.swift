//
//  ContentView.swift
//  EarnIt
//
//  Created by Ryan Jones on 10/29/20.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) var context
  
  var body: some View {
    HStack {
    TabView {
      ChoreListView().environment(\.managedObjectContext, context)
        .tabItem {
          Image(systemName: "list.bullet")
          Text("Chores")
      }
      CompletedChoreListView().environment(\.managedObjectContext, context)
        .tabItem {
          Image(systemName: "text.badge.checkmark")
          Text("Completed Chores")
        }
      }
    }
  }
}

/*
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
*/
