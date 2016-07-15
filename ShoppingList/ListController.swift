//
//  ListController.swift
//  ShoppingList
//
//  Created by Joseph Hansen on 7/15/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class ListController {
    static let sharedController = ListController()
    let fetchedResultsController: NSFetchedResultsController
    
    init() {
        let request = NSFetchRequest(entityName: "List")
        let sortDescriptor1 = NSSortDescriptor(key: "name", ascending: false)
        let sortDescriptor2 = NSSortDescriptor(key: "category", ascending: false)
        let sortDescriptor3 = NSSortDescriptor(key: "haveItem", ascending: false)
        request.sortDescriptors = [sortDescriptor1, sortDescriptor2, sortDescriptor3]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "category", cacheName: nil)
        _ = try? fetchedResultsController.performFetch()
    }
    func addItem(name: String, category: String) {
        _ = List(name: name, category: category)
        saveToPersistentStore()
    }
    func deleteItem(list: List) {
        list.managedObjectContext?.deleteObject(list)
        saveToPersistentStore()
    }
    func updateItem(list: List, haveItem: Bool) {
        list.haveItem = haveItem
        saveToPersistentStore()
    }
    func haveItemValueToggled(list: List) {
        list.haveItem = !list.haveItem.boolValue
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        }catch {
            print("Error Saving Managed Object Context")
        }
    }
    
}
