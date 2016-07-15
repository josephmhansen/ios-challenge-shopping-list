//
//  List.swift
//  ShoppingList
//
//  Created by Joseph Hansen on 7/15/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class List: NSManagedObject {
    convenience init?(name: String, haveItem: Bool = false, category: String, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let entity = NSEntityDescription.entityForName("List", inManagedObjectContext: context) else {return nil}
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
        self.haveItem = haveItem
        self.category = category
        
        
        
    }
}
