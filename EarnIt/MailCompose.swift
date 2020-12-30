//
//  MailCompose.swift
//  EarnIt
//
//  Created by Ryan Jones on 12/30/20.
//

import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {
  @FetchRequest(entity: CompletedChore.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CompletedChore.completedDate, ascending: false)]) var completedChores: FetchedResults<CompletedChore>
  @Environment(\.presentationMode) var presentation
  @Binding var result: Result<MFMailComposeResult, Error>?
  
  var sum: Double {
    completedChores.reduce(0) { $0 + $1.amount }
  }
  
  class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
    
    @Binding var presentation: PresentationMode
    @Binding var result: Result<MFMailComposeResult, Error>?
    
    init(presentation: Binding<PresentationMode>,
         result: Binding<Result<MFMailComposeResult, Error>?>) {
      _presentation = presentation
      _result = result
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
      defer {
        $presentation.wrappedValue.dismiss()
      }
      guard error == nil else {
        self.result = .failure(error!)
        return
      }
      self.result = .success(result)
    }
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(presentation: presentation,
                       result: $result)
  }
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
    let vc = MFMailComposeViewController()
    vc.mailComposeDelegate = context.coordinator
    vc.setSubject("I Earned It!")
    vc.setMessageBody("Chores...", isHTML: false)
    return vc
  }
  
  func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                              context: UIViewControllerRepresentableContext<MailView>) {
  }
}
