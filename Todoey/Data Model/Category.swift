//
//  Category.swift
//  Todoey
//
//  Created by James Mathur on 1/17/19.
//  Copyright © 2019 James Mathur. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
