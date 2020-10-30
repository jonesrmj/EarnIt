//
//  Chore.swift
//  EarnIt
//
//  Created by Ryan Jones on 10/18/20.
//

import Foundation
import SwiftUI
import Combine

struct Chore : Identifiable {
  var id = String()
  var description = String()
  var amount = Double()
}

class ChoreStore : ObservableObject {
  @Published var chores: [Chore] = []
}
