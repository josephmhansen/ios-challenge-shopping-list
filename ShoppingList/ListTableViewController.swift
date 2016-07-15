//
//  ListTableViewController.swift
//  ShoppingList
//
//  Created by Joseph Hansen on 7/15/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController, ListTableViewCellDelegate, NSFetchedResultsControllerDelegate {
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        var itemTextField: UITextField?
        var categoryTextField: UITextField?
        
        let alert = UIAlertController(title: "New Item", message: "What do you want to add?", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler{ (textField) in
            textField.placeholder = "Enter item"
            itemTextField = textField
            
        }
        alert.addTextFieldWithConfigurationHandler{ (textField) in
            textField.placeholder = "Perishable/NonPerishable"
            categoryTextField = textField
        }
        let submitAction = UIAlertAction(title: "Submit", style: .Default) { (_) in
            guard let itemText = itemTextField?.text, categoryText = categoryTextField?.text else {return}
            ListController.sharedController.addItem(itemText, category: categoryText)
            
        }
        let dismissAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
        alert.addAction(submitAction)
        alert.addAction(dismissAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ListController.sharedController.fetchedResultsController.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return ListController.sharedController.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = ListController.sharedController.fetchedResultsController.sections else {return 0}
        
        return sections[section].numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as? ListTableViewCell, let list = ListController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? List else {return UITableViewCell() }
        cell.updateWithItem(list)
        cell.delegate = self

        // Configure the cell...

        return cell
    }
    func haveItemValueChanged(cell: ListTableViewCell, haveItem: Bool) {
        guard let list = cell.list else { return }
        ListController.sharedController.haveItemValueToggled(list)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

   
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            guard let list = ListController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? List else {return}
            ListController.sharedController.deleteItem(list)
            
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = ListController.sharedController.fetchedResultsController.sections, let index = Int(sections[section].name) else { return nil }
        if index == 0 {
            return "Keep Cold"
        } else if index == 1 {
            return "Non Perishable"
        } else {
            return nil
        }
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case.Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        case.Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        default:
            break
        }
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case.Delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case.Insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case.Update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case.Move:
            guard let indexPath = indexPath, newIndexPath = newIndexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
  

}
