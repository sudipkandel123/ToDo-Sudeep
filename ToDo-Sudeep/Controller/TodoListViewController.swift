//
//  ViewController.swift
//  ToDo-Sudeep
//
//  Created by Sudip on 10/14/18.
//  Copyright © 2018 Sudeepasa. All rights reserved.
//

import UIKit
import RealmSwift// i forgot this and couldnot perform the NSFetchRequest

class TodoListViewController: UITableViewController /*,UITableViewDataSource,UITableViewDelegate*/{
//a sample array to store todO list
    
    
   let realm = try! Realm()
    
    var todoItem : Results<Item>?
    //let defaults = UserDefaults.standard // store key value pair for persistent launch of the application
    //default is the object of the userDefaults
   // var itemArray = [Item]() //from Title.swift class we take the Item object
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    //tableView.delegate = self
    //tableView.dataSource = self
    //this view controller automatically provides the delegates for the tableviewcontroller
    
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist") //file manager is a singleton which has urls for document directory in userDomainMask where user personal data are stored and it is array
 
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //from UIapplication delegate is shared and downcasted to appdelegate and  is converted to context
    
///////////////////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        //print("view did load")
        super.viewDidLoad()
       
         loadItems()
        
        
        //defaults is the userDefaults object
        //error - i got an error here when i didnt use optional after type casting thread expection error
//        if let items = defaults.array(forKey: "ToDOList") as? [Item]{
//            itemArray = items // this items is from if let
//        }
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////////////////
    //MARK: - Tableview Datasource methods
    //a tableview checks for number of rows and returns total items in the array
    //cell hold the tableview and since table view has cells which are reusable after scrolling
    //textlabel in tableview takes the array element from indexpath and return the cell.
    
    
    /////////////////////////////////////////////////////////////////////////////////
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return todoItem?.count ?? 1
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////////////////
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        if let item = todoItem?[indexPath.row]{
            cell.textLabel?.text = item.title
            
            //Ternary operator
            //value = condition ? valueIfTrue : valueIfFalse
            
            cell.accessoryType = item.done ? .checkmark : .none
            //instead of if else we used a ternary operator
            
        }
        else{
            cell.textLabel?.text = "No Items Added"
        }
        return cell
        // i got a error here when i did a typo mistake in indexPath as Indexpath
        //i got an error while running the code because i mistype the TodoItemCell a typo mistake again
    }
    
    
    
    
    
    /////////////////////////////////////////////////////////////////////////////////
    //MARK :- TableView Delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItem?[indexPath.row]{
            do{
                 try realm.write {
                item.done = !item.done
                }}
            catch{
                print("Error saving the data \(error)")

            }
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        
    }
        
        
        
        
        
//        //print(itemArray[indexPath.row]) //this will print what user has selected like which tableview user has selected
//         tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
////        context.delete(itemArray[indexPath.row])
////        itemArray.remove(at: indexPath.row )
////        todoItem[indexPath.row].done = !todoItem[indexPath.row].done
////        //if itemArray is ch ecked then when button presses it will be unchecked and vice-versa.
////
////        saveItem()
////        //tableView.reloadData() //this is required because each time we need to refresh the action performed by the user
//
//
//        //if user selects first one then the console will return 0
    
///////////////////////////////////////////////////////////////////////////////////////////
    
    
//MARK:- Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField() ///because the alertTextfield is only accessible inside the addtextfield method we want it to be available gloabally so if textfield holds the alerttextfield, then it is accessible globally //matlap scope increase garna visibility of the code
        
        let alert = UIAlertController(title: "Add new Todo List", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item in the uiAlert view
            //print(textField.text!)
            
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                    let newItem = Item() //the context where item is going to be stored
                    newItem.title = textField.text!
                    newItem.dateCreated = Date() //every newItem we create we will have a date
                    currentCategory.items.append(newItem)
                }
            }
                catch{
                    print("The error has occured \(error)")
                }}
            self.tableView.reloadData() //once the new element is added to the itemArray we need to reload the new data to make it displayable in the tableview
            
            
//            newItem.parentCategory = self.selectedCategory
//             self.itemArray.append(newItem) //add new array element into itemArray //remember to put self as it is inside the closure
//            self.saveItem()
//
//            //self.defaults.set(self.itemArray, forKey: "ToDOList")
//
//
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
    
    // MARK: - Model Manipulation method
    
////////////////////////////////////////////////////////////////////////////////////////////
    //saveItem is used to encode the item and done into the plist which will store as a key value or any other pair

//    func saveItem(){
//        do{
//
//
//
////
////            let data = try encoder.encode(itemArray)
////            try data.write(to: dataFilePath!) // i was getting error as the item.swift file was not encodable so when using encoding the referenced files should be made encodable and the file should contain only defined datatype rather than the functions.
//        }
//        catch
//
//        {
//            print("error saving context \(error)")
//
//        }
//        self.tableView.reloadData()
//
//    }
    
    
    /////////////////////////////////////////////////////////////////////////////////
    func loadItems(){
    //func loadItems(with request : NSFetchRequest <Item> = Item.fetchRequest() ,predicate: NSPredicate? = nil) //function to save data into core data file
        //in this function we are using internal parameter(request) external parameter(with) and if this function receives a parameter then NSFetchRequest takes the input else the default(Item.fetchRequest() works

    todoItem = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
        
    }

//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        //rewriting the below code using optional binding
//        if let additionalPredicate = predicate{
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
//        }
//        else
//        {
//            request.predicate = categoryPredicate
//        }
//
//
//
//
//
////        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate])
////        request.predicate = predicate
//        //let request : NSFetchRequest <Item> = Item.fetchRequest()
//        do {
//          itemArray =  try context.fetch(request)
//        }
//            catch {
//                print("error fetching from data \(error)")
//            }
       
    
    

}

// MARK: - SearchBarDelegate
extension TodoListViewController : UISearchBarDelegate
//a extension of todolistviewcontroller which inherits UISearchBarDelegate and performs its functionalities
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItem = todoItem?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
        
    }
        
        
        
        
//         let request : NSFetchRequest <Item> = Item.fetchRequest() //request fetchs the item from the core data and gives the fetched item and stores in the request
//        //print(searchBar.text!) //searchBar.text! takes the input given by the user in the searchBar
//let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!) //predicates in this let are like string comparisor where it queries title where contains is a comparision operator . string formats are case sensitive and [cd - case diacritic]
//        //predicates are used for requesting certain conditions
//       request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        //request.sortDescriptors = [sortDescriptor]
//
//
//        loadItems(with: request , predicate: predicate) // sends the request to the loadItem method
//
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0
        {
            loadItems()

            DispatchQueue.main.async
                //Dispatch Queue are used to maintain thread property
                {
                    searchBar.resignFirstResponder() //to remove keyboard and cursor from the search bar.

            }

        }
    }

    }



