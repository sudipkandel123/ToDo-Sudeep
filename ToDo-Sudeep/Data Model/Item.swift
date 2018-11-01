
//
//  Item.swift
//  ToDo-Sudeep
//
//  Created by Sudip on 11/1/18.
//  Copyright © 2018 Sudeepasa. All rights reserved.
//

import Foundation
import RealmSwift
class Item : Object{
    @objc dynamic var title : String = ""
    @objc dynamic var dateCreated :Date?
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
    
}
