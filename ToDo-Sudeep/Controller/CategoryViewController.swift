//
//  CategoryViewController.swift
//  ToDo-Sudeep
//
//  Created by Sudip on 10/27/18.
//  Copyright © 2018 Sudeepasa. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    var categories = [Category]() // a object of the class Category

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

    }

    
    //MARK: - ADD Button Pressed
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField() //reference to the addTextField
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text
            self.categories.append(newCategory)
            self.saveCategories()
            
            
        }
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new Category"
            
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
        
    }
    
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCategoryCell",for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    
     //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController //force downcast
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    
    
    //MARK: - Data Manipulation Methods
    
    func loadCategories(){
        let request:NSFetchRequest<Category> = Category.fetchRequest() //fetch all the nsmanager objects that are created using Category entity
        do{
            categories = try context.fetch(request) // we are going to store the result from context.fetch(request) into category array
            
        }
        catch{
            print("Error recieved while loading \(error)")
            
        }
        
        
        
    }
    
    func saveCategories(){
        do{
          
            try context.save()
        }
        catch{
            print("Error in saving the items \(error)")
        }
        tableView.reloadData()
        
    }
    
    
    //MARK: - Add New Category Method
    
    
    
    
    
    
    
    
   
    
    
    
    
}
