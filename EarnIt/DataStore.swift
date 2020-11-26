//
//  DataStore.swift
//  EarnIt
//
//  Created by Ryan Jones on 11/26/20.
//

import Foundation
import CoreData

class DataStore {
  static let shared = DataStore()
  
  let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "EarnItDataModel")
    container.loadPersistentStores { description, error in
      if let error = error {
        print(error)
      }
      
    }
    return container
  }()
  
  private init() {
    
  }
  
  public func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        print(error)
      }
    }
  }
}
