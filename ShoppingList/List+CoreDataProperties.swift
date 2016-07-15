//
//  List+CoreDataProperties.swift
//  ShoppingList
//
//  Created by Joseph Hansen on 7/15/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension List {

    @NSManaged var category: String
    @NSManaged var haveItem: NSNumber
    @NSManaged var name: String

}
