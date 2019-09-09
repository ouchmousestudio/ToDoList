//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by Miles Fearnall-Williams on 2019/09/08.
//  Copyright © 2019 Miles Fearnall-Williams. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

    
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
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        //Get color from Realm, if there's no color, then add a random color
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? UIColor.randomFlat.hexValue())

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
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        
        super.updateModel(at: indexPath)
        
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    //delete data from realm
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting \(error)")
            }
        }

    }

    
    //MARK: - Add new categories
    
    
    @IBAction func addBarPressed(_ sender: UIBarButtonItem) {
        
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add", style: .default) { (action) in
        
        let newCategory = Category()
        newCategory.name = textField.text!
        newCategory.color = UIColor.randomFlat.hexValue()
        
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

