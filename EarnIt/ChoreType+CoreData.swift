//
//  ChoreType+CoreData.swift
//  EarnIt
//
//  Created by Ryan Jones on 11/26/20.
//

import Foundation
import CoreData

@objc(ChoreType)
public class ChoreType: NSManagedObject {
  @NSManaged public var id: UUID
  @NSManaged public var name: String?
  @NSManaged public var amount: Double
}

