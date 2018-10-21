//
//  ViewController.swift
//  ToDo-Sudeep
//
//  Created by Sudip on 10/14/18.
//  Copyright © 2018 Sudeepasa. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController/*,UITableViewDataSource,UITableViewDelegate*/{
//a sample array to store todO list
    let defaults = UserDefaults.standard // store key value pair for persistent launch of the application
    //default is the object of the userDefaults
    
    
    //tableView.delegate = self
    //tableView.dataSource = self
    //this view controller automatically provides the delegates for the tableviewcontroller
    var itemArray = ["Buy Peanut butter","Get my watch from alibaba","Get a sticky keypad"]
    override func viewDidLoad() {
        //print("view did load")
        super.viewDidLoad()
        
        //defaults is the userDefaults object
        //error - i got an error here when i didnt use optional after type casting thread expection error
        if let items = defaults.array(forKey: "ToDOList") as? [String]{
            itemArray = items
        }
    }
    //MARK - Tableview Datasource methods
    //a tableview checks for number of rows and returns total items in the array
    //cell hold the tableview and since table view has cells which are reusable after scrolling
    //textlabel in tableview takes the array element from indexpath and return the cell.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        // i got a error here when i did a typo mistake in indexPath as Indexpath
        //i got an error while running the code because i mistype the TodoItemCell a typo mistake again
    }
    
//MARK - TableView Delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row]) //this will print what user has selected like which tableview user has selected
         //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none

        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }

        
        //if user selects first one then the console will return 0
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK : - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField() ///because the alertTextfield is only accessible inside the addtextfield method we want it to be available gloabally so if textfield holds the alerttextfield, then it is accessible globally //matlap scope increase garna visibility of the code
        
        let alert = UIAlertController(title: "Add new Todo List", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item in the uiAlert view
            //print(textField.text!)
             self.itemArray.append(textField.text!) //add new array element into itemArray //remember to put self as it is inside the closure
            self.defaults.set(self.itemArray, forKey: "ToDOList")
            self.tableView.reloadData() //once the new element is added to the itemArray we need to reload the new data to make it displayable in the tableview
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            // print(alertTextField.text)
        }
        alert.addAction(action)
        //now to present that is to let it popup in the screen ie present view controller modally
        present(alert, animated: true, completion: nil)
        //till here when user press + the pop up will appear saying add items from the alert-action
        //so it matters if we provide present before suppose if we provide present before then it wont be sequenced properly
           
    }
}


