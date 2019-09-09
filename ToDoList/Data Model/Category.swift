//
//  Category.swift
//  ToDoList
//
//  Created by Miles Fearnall-Williams on 2019/09/09.
//  Copyright © 2019 Miles Fearnall-Williams. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
