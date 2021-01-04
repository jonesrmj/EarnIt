//
//  ChoreRow.swift
//  EarnIt
//
//  Created by Ryan Jones on 10/29/20.
//

import SwiftUI

struct ChoreRowView: View {
  @Environment(\.managedObjectContext) var context
  
  let chore: Chore
  
  var currencyFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.isLenient = true
    f.numberStyle = .currency
    return f
  }()
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(chore.name ?? "")
        .font(.subheadline)
        .padding(.bottom, 5.0)
      Text("$" + String(chore.amount))
        .font(.caption)
    }
    .padding(.vertical, 10.0)
    .onTapGesture {
      addCompletedChore(name: chore.name!, amount: chore.amount)
    }
  }
  
  func addCompletedChore(name: String, amount: Double) {
    let now = Date()
    let newChore = CompletedChore(context: context)
    newChore.name = name
    newChore.amount = amount
    newChore.completedDate = now
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
struct ChoreRowView_Previews: PreviewProvider {
  static var previews: some View {
    ChoreRowView()
  }
}
*/
