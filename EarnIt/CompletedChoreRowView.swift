//
//  CompletedChoreRowView.swift
//  EarnIt
//
//  Created by Ryan Jones on 12/28/20.
//

import SwiftUI

struct CompletedChoreRowView: View {
  @Environment(\.managedObjectContext) var context
  
  let completedChore: CompletedChore
  
  var currencyFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.isLenient = true
    f.numberStyle = .currency
    return f
  }()
  
  var dateFormatter: DateFormatter = {
    var formatter = DateFormatter()
    formatter.dateFormat = "M/dd/yy h:mm:ssa"
    formatter.amSymbol = "am"
    formatter.pmSymbol = "pm"
    return formatter
  }()
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(completedChore.name ?? "")
        .font(.subheadline)
        .padding(.bottom, 5.0)
      HStack {
        Text("$" + String(completedChore.amount))
          .font(.caption)
        Spacer()
        Text(dateFormatter.string(from: completedChore.completedDate!))
          .font(.caption)
      }
    }
    .padding(.vertical, 10.0)
  }
}

/*
struct CompletedChoreRowView_Previews: PreviewProvider {
  static var previews: some View {
    CompletedChoreRowView()
  }
}
*/
