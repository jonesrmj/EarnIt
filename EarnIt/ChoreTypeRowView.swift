//
//  ChoreRow.swift
//  EarnIt
//
//  Created by Ryan Jones on 10/29/20.
//

import SwiftUI

struct ChoreTypeRowView: View {
  let choreType: ChoreType
  
  var currencyFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.isLenient = true
    f.numberStyle = .currency
    return f
  }()
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(choreType.name ?? "")
        .font(.subheadline)
        .padding(.bottom, 5.0)
      Text("$" + String(choreType.amount))
        .font(.caption)
    }
    .padding(.vertical, 10.0)
  }
}

/*
struct ChoreRowView_Previews: PreviewProvider {
  static var previews: some View {
    ChoreRowView()
  }
}
*/
