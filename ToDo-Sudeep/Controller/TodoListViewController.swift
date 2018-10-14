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
    
    //tableView.delegate = self
    //tableView.dataSource = self
    //this view controller automatically provides the delegates for the tableviewcontroller
    let itemArray = ["Buy Peanut butter","Get my watch from alibaba","Get a sticky keypad"]
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

