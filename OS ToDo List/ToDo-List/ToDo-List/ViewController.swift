//
//  ViewController.swift
//  ToDo-List
//
//  Created by Thomas Cowern New on 9/17/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var importantChecked: NSButton!
    
    @IBOutlet weak var textField: NSTextField!
    
    @IBOutlet weak var deleteButton: NSButton!
    
    var toDoItems : [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getToDoItems()
        // Do any additional setup after loading the view.
    }
    
    func getToDoItems() {
        
        // get all the todo items to display from core data
        
        if let context = ((NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext) {
            
            do {
                //set them to the class property
                toDoItems = try context.fetch(ToDoItem.fetchRequest())
                print(toDoItems.count)
            } catch  {
                print("getToDoItems catch")
            }
            
        }
        
        
        
        //display them to the table
        tableView.reloadData()
        
        
    }
    
    @IBAction func addClicked(_ sender: Any) {
        
        if textField.stringValue != "" {
            
            if let context = ((NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext) {
                
                let toDoItem = ToDoItem(context: context)
                
                //                    ToDoItem(context: context)
                
                toDoItem.name = textField.stringValue
                
                if importantChecked.state.rawValue == 0 {
                    //not important
                    toDoItem.important = false
                } else {
                    //important
                    toDoItem.important = true
                }
                
                (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
                
                textField.stringValue = ""
                importantChecked.state = NSControl.StateValue(rawValue: 0)
                
                getToDoItems()
            }
            
        }
        
    }
    
    
    @IBAction func deletePressed(_ sender: Any) {
        
        let toDoItem = toDoItems[tableView.selectedRow]
        
        if let context = ((NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext) {
            
            context.delete(toDoItem)
            
            (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
            
            getToDoItems()
            
            deleteButton.isHidden = true
        }
    }
    
    // MARK: - Tableview Section
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let toDoItem = toDoItems[row]
        
        // Important Column
        if (tableColumn?.identifier)!.rawValue == "importantColumn" {
            
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "importantCell"), owner: self) as? NSTableCellView {
                
                if toDoItem.important {
                    
                    cell.textField?.stringValue = "   ❗️"
                    
                } else {
                    
                    cell.textField?.stringValue = ""
                }
                
                return cell
            }
            
        } else {
            // toDo Name
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "toDoItems"), owner: self) as? NSTableCellView {
                
                cell.textField?.stringValue = toDoItem.name!
                
                return cell
            }
        }
        
        return nil
        
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        deleteButton.isHidden = false
    }
}

