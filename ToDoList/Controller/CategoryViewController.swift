//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by Miles Fearnall-Williams on 2019/09/08.
//  Copyright © 2019 Miles Fearnall-Williams. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    
    let realm = try! Realm()
    
    var categories : Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
    }
    
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
        //MARK: - Data manipulation Methods
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
                }
        }
        catch {
            print("Error saving category \(error)")
        }
        self.tableView.reloadData()
    }
    
    //Load from persisted storage
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }

    
    //MARK: - Add new categories
    
    
    @IBAction func addBarPressed(_ sender: UIBarButtonItem) {
        
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add", style: .default) { (action) in
        
        let newCategory = Category()
        newCategory.name = textField.text!
        
        self.save(category: newCategory)
        
    }
        alert.addTextField { (categoryField) in
        categoryField.placeholder = "Create new Category"
        textField = categoryField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
