//
//  CompletedChoreListView.swift
//  EarnIt
//
//  Created by Ryan Jones on 11/23/20.
//

import SwiftUI
import MessageUI

struct CompletedChoreListView: View {
  @Environment(\.managedObjectContext) var context
  @FetchRequest(entity: CompletedChore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CompletedChore.completedDate, ascending: false)], predicate: NSPredicate(format: "invoicedDate = nil")) var completedChores: FetchedResults<CompletedChore>
  
  @State var isEmailPresented = false
  @State var result: Result<MFMailComposeResult, Error>? = nil
  @State var emailString = ""
  
  var sum: Double {
    completedChores.reduce(0) { $0 + $1.amount }
  }
  
  var currencyFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.isLenient = true
    f.numberStyle = .currency
    return f
  }()
  
  var dateFormatter: DateFormatter = {
    var formatter = DateFormatter()
    formatter.dateFormat = "M/dd/yy"
    formatter.amSymbol = "am"
    formatter.pmSymbol = "pm"
    return formatter
  }()
  
  var body: some View {
    NavigationView {
      VStack {
        if #available(iOS 14.0, *) {
          List {
            ForEach(self.completedChores, id: \.self) {
              CompletedChoreRowView(completedChore: $0)
            }
            .onDelete(perform: self.deleteCompletedChore)
          }
          .listStyle(InsetGroupedListStyle())
        } else {
          List {
            ForEach(self.completedChores, id: \.self) {
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
            Button(action: {
              self.createEmailText(withManagedObjects: self.completedChores)
              self.isEmailPresented.toggle()
            }) {
              Image(systemName: "envelope")
            }
            .disabled(!MFMailComposeViewController.canSendMail() || completedChores.isEmpty)
          }
        }
      )
    }
    .sheet(isPresented: $isEmailPresented, onDismiss: {
      switch result {
      case .success(let mailResult):
        if (mailResult == .sent) {
          setInvoiceDates()
        }
      default:
        print("Error generating email")
      }
    }) {
      MailView(result: self.$result, emailString: self.$emailString)
    }
  }

  func setInvoiceDates() {
    completedChores.forEach { chore in
      chore.invoicedDate = Date()
    }
    saveContext()
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
  
  func createEmailText(withManagedObjects arrManagedObject: FetchedResults<CompletedChore>) {
    var total = 0.00
    emailString = "Hello, \n \n I have completed the following chores: \n \n"
    arrManagedObject.forEach { (completedChore) in
      let entityContent = "\(dateFormatter.string(from: completedChore.completedDate!)) - \(completedChore.name ?? "") (\( currencyFormatter.string(from: NSNumber(value: completedChore.amount)) ?? "$0.00")) \n"
      total = total + completedChore.amount
      emailString.append(entityContent)
    }
    emailString.append("\n The total amount is $\(String(total)). \n \n Please pay me when you can! \n \n Thanks!")
  }
}

/*
struct CompletedChoreListView_Previews: PreviewProvider {
  static var previews: some View {
    CompletedChoreListView()
  }
}
*/
