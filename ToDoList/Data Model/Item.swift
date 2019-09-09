//
//  Item.swift
//  ToDoList
//
//  Created by Miles Fearnall-Williams on 2019/09/09.
//  Copyright © 2019 Miles Fearnall-Williams. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
