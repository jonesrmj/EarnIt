//
//  ContentView.swift
//  EarnIt
//
//  Created by Ryan Jones on 10/29/20.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      ChoreListView()
        .tabItem {
          Image(systemName: "list.bullet")
          Text("Chores")
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
