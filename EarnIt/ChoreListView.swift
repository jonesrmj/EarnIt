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
            ForEach(self.choreStore.chores, id: \.id) {
              ChoreRowView(chore: $0)
            }
            .onDelete(perform: self.deleteChore)
          }
          .listStyle(InsetGroupedListStyle())
        } else {
          List {
            ForEach(self.choreStore.chores) { chore in
              Text(chore.description + " | " + String(chore.amount))
            }
            .onDelete(perform: self.deleteChore)
          }
          .listStyle(InsetGroupedListStyle())
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
    .sheet(isPresented: self.$isAddChorePresented) {
      AddChoreView(isAddChorePresented: self.$isAddChorePresented) { description, amount in
        self.addChore(description: description, amount: amount)
        self.isAddChorePresented = false
      }
    }
  }
  
  func deleteChore(at offSets: IndexSet) {
    choreStore.chores.remove(atOffsets: offSets)
  }
  
  func addChore(description: String, amount: Double) {
    let newChore = Chore(id: String(choreStore.chores.count + 1), description: description, amount: amount)
    choreStore.chores.append(newChore)
  }
}

/*
struct ChoreListView_Previews: PreviewProvider {
  static var previews: some View {
    ChoreListView()
  }
}
*/
