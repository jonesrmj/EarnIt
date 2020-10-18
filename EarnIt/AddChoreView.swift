//
//  AddChoreView.swift
//  EarnIt
//
//  Created by Ryan Jones on 10/18/20.
//

import SwiftUI

struct AddChoreView: View {
  @ObservedObject var choreStore = ChoreStore()
  @State var newChoreDescription : String = ""
  @State var newChoreAmount : Double = 0.0
  
  var currencyFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.isLenient = true
    f.numberStyle = .currency
    return f
  }()
  
  let onComplete: (String, Double) -> Void
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Description")        .padding(.top, 25)) {
          TextField("Description", text: self.$newChoreDescription)
        }
        Section(header: Text("Amount")) {
          TextField("Amount", value: $newChoreAmount, formatter: currencyFormatter)
            .keyboardType(.decimalPad)
        }
        Button(action: {
          addNewChore()
        }) {
          Text("Add Chore")
        }
      }
      .navigationBarTitle(Text("Add Chore"), displayMode: .inline)
      .navigationBarItems(leading: HStack {
        Button(action: {}) {
          Text("Cancel")
        }
      })
    }
  }
  
  func addNewChore() {
    onComplete(newChoreDescription, newChoreAmount)
  }
}

/*
struct AddChoreView_Previews: PreviewProvider {
  static var previews: some View {
    AddChoreView()
  }
}
*/
