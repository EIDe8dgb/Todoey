//
//  CategoryViewController.swift
//  Todoey
//
//  Created by James Mathur on 1/17/19.
//  Copyright © 2019 James Mathur. All rights reserved.
//

import UIKit
import RealmSwift




class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //nil coalescing operator
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
    
    
    }
    
        //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Data Manipulation Methods
    
    
    func save(category: Category){
        
        
        do{
            try realm.write{
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
    func loadCategories() {
        
         categories = realm.objects(Category.self)
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//        do{
//            categories = try context.fetch(request)
//        } catch {
//            print("Error fetching categories \(error)")
//        }
//
        tableView.reloadData()
    }
    
    
    //MARK: Add New Categories
    
    
    
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what will happen once the use clicks the Add Item button on our UI Alert
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            
            textField = field
            textField.placeholder = "Add a new category"
            
        }
    
        present(alert, animated: true, completion: nil)

    
    
    

    
    
    
    
    
}
}
