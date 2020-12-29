//
//  AddChoreView.swift
//  EarnIt
//
//  Created by Ryan Jones on 10/18/20.
//

import SwiftUI

struct AddChoreView: View {
  @State var choreName : String = ""
  @State var choreAmount : Double = 0.0
  
  @Binding var isAddChorePresented: Bool
  
  var currencyFormatter: NumberFormatter = {
    let f = NumberFormatter()
    // allow no currency symbol, extra digits, etc
    f.isLenient = true
    f.numberStyle = .currency
    return f
  }()
  
  let onComplete: (String, Double) -> Void
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Name").padding(.top, 25)) {
          TextField("Name", text: self.$choreName)
        }
        Section(header: Text("Amount")) {
          TextField("Amount", value: $choreAmount, formatter: currencyFormatter)
        }
        Button(action: {
          addNewChore()
        }) {
          Text("Add Chore")
        }
      }
      .navigationBarTitle(Text("Add Chore"), displayMode: .inline)
      .navigationBarItems(leading: HStack {
        Button(action: { isAddChorePresented.toggle() }) {
          Text("Cancel")
        }
      })
    }
  }
  
  func addNewChore() {
    onComplete(choreName, choreAmount)
  }
}

/*
 struct AddChoreView_Previews: PreviewProvider {
 static var previews: some View {
 AddChoreView()
 }
 }
 */
