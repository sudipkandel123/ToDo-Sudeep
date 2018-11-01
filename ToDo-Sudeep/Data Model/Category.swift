//
//  Category.swift
//  ToDo-Sudeep
//
//  Created by Sudip on 11/1/18.
//  Copyright © 2018 Sudeepasa. All rights reserved.
//

import Foundation
import RealmSwift
class Category : Object{
    
    @objc dynamic var name : String = ""
    let items = List<Item>() //each category has one to many relationship with the list of items.
}
