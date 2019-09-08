//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by Miles Fearnall-Williams on 2019/09/08.
//  Copyright © 2019 Miles Fearnall-Williams. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
        //MARK: - Data manipulation Methods
    
    func saveCategories()
        
    {
        do {
            try context.save()
        }
        catch {
            print("Error saving category \(error)")
        }
        self.tableView.reloadData()
    }
    
    //Load from persisted storage
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error loading category \(error)")
        }
        tableView.reloadData()
    }

    
    //MARK: - Add new categories
    
    
    @IBAction func addBarPressed(_ sender: UIBarButtonItem) {
        
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add", style: .default) { (action) in
        
        let newCategory = Category(context: self.context)
        newCategory.name = textField.text!
        
        self.categoryArray.append(newCategory)
        self.saveCategories()
        
    }
        alert.addTextField { (categoryField) in
        categoryField.placeholder = "Create new Category"
        textField = categoryField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
