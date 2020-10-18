//
//  ContentView.swift
//  EarnIt
//
//  Created by Ryan Jones on 10/5/20.
//

import SwiftUI
import Combine

struct ChoreListView: View {
  @ObservedObject var choreStore = ChoreStore()
  @State var isAddChorePresented = false
  
  var body: some View {
    NavigationView {
      VStack {
        if #available(iOS 14.0, *) {
          List {
            ForEach(self.choreStore.chore) { chore in
              Text(chore.description + " | $" + String(chore.amount))
            }
            .onDelete(perform: self.deleteChore)
          }
          .listStyle(InsetGroupedListStyle())
          .sheet(isPresented: $isAddChorePresented) {
            AddChoreView { description, amount in
              self.addChore(description: description, amount: amount)
              self.isAddChorePresented = false
            }
          }
        } else {
          List {
            ForEach(self.choreStore.chore) { chore in
              Text(chore.description + " | " + String(chore.amount))
            }
            .onDelete(perform: self.deleteChore)
          }
          .listStyle(InsetGroupedListStyle())
          .sheet(isPresented: $isAddChorePresented) {
            AddChoreView { description, amount in
              self.addChore(description: description, amount: amount)
              self.isAddChorePresented = false
            }
          }
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
            Button(action: { self.isAddChorePresented.toggle() }) {
              Image(systemName: "plus")
            }
          }
        }
      )
    }
  }
  
  func deleteChore(at offSets: IndexSet) {
    choreStore.chore.remove(atOffsets: offSets)
  }
  
  func addChore(description: String, amount: Double) {
    let newChore = Chore(description: description, amount: amount)
    choreStore.chore.append(newChore)
  }
}

struct ChoreListView_Previews: PreviewProvider {
  static var previews: some View {
    ChoreListView()
  }
}
