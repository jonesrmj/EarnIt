//
//  ContentView.swift
//  EarnIt
//
//  Created by Ryan Jones on 10/5/20.
//

import SwiftUI
import Combine

struct ChoreListView: View {
  @Environment(\.managedObjectContext) var context
  @FetchRequest(entity: Chore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Chore.name, ascending: true)]) var chores: FetchedResults<Chore>
  
  @State var isAddChorePresented = false
  
  var body: some View {
    NavigationView {
      VStack {
        if #available(iOS 14.0, *) {
          List {
            ForEach(self.chores, id: \.name) {
              ChoreRowView(chore: $0)
            }
            .onDelete(perform: self.deleteChore)
          }
          .listStyle(InsetGroupedListStyle())
        } else {
          List {
            ForEach(self.chores, id: \.name) {
              ChoreRowView(chore: $0)
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
            Button(action: { self.isAddChorePresented.toggle() }) {
              Image(systemName: "plus")
            }
          }
        }
      )
    }
    .sheet(isPresented: self.$isAddChorePresented) {
      AddChoreView(isAddChorePresented: self.$isAddChorePresented) { name, amount in
        self.addChore(name: name, amount: amount)
        self.isAddChorePresented = false
      }
    }
  }
  
  func deleteChore(at offsets: IndexSet) {
    offsets.forEach { index in
      let chore = self.chores[index]
      self.context.delete(chore)
    }
    saveContext()
  }
  
  func addChore(name: String, amount: Double) {
    let newChore = Chore(context: context)
    newChore.name = name
    newChore.amount = amount
    saveContext()
  }
  
  func saveContext() {
    do {
      try context.save()
    } catch {
      print("Error saving managed object context: \(error)")
    }
  }
}

/*
struct ChoreListView_Previews: PreviewProvider {
  static var previews: some View {
    ChoreListView()
  }
}
*/
