//
//  CompletedChoreListView.swift
//  EarnIt
//
//  Created by Ryan Jones on 11/23/20.
//

import SwiftUI

struct CompletedChoreListView: View {
  @Environment(\.managedObjectContext) var context
  @FetchRequest(entity: CompletedChore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CompletedChore.completedDate, ascending: false)]) var completedChores: FetchedResults<CompletedChore>
  
  var sum: Double {
    completedChores.reduce(0) { $0 + $1.amount }
  }
  
  var body: some View {
    NavigationView {
      VStack {
        if #available(iOS 14.0, *) {
          List {
            ForEach(self.completedChores, id: \.name) {
              CompletedChoreRowView(completedChore: $0)
            }
            .onDelete(perform: self.deleteCompletedChore)
          }
          .listStyle(InsetGroupedListStyle())
        } else {
          List {
            ForEach(self.completedChores, id: \.name) {
              CompletedChoreRowView(completedChore: $0)
            }
            .onDelete(perform: self.deleteCompletedChore)
          }
          .listStyle(InsetGroupedListStyle())
        }
      }
      .navigationBarTitle(Text("$" + String(sum) + " Earned"))
      .navigationBarItems(trailing:
        HStack {
          VStack {
            Button(action: {}) {
              Image(systemName: "envelope")
            }
          }
        }
      )
    }
  }
  
  func deleteCompletedChore(at offsets: IndexSet) {
    offsets.forEach { index in
      let completedChore = self.completedChores[index]
      self.context.delete(completedChore)
    }
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
struct CompletedChoreListView_Previews: PreviewProvider {
  static var previews: some View {
    CompletedChoreListView()
  }
}
*/
