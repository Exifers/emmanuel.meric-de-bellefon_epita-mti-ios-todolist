//
//  TodoItem.swift
//  TodoList
//
//  Created by epita on 12/06/2019.
//  Copyright © 2019 epita. All rights reserved.
//

import UIKit

class TodoItem: NSObject {
    var value:String
    var completed:Bool
    var creationDate:Date
    var color:TodoItemColor?
    
    init(value:String, color:TodoItemColor) {
        self.value = value
        self.completed = false
        self.creationDate = Date()
        self.color = color
    }
    
    init(value:String) {
        self.value = value
        self.completed = false
        self.creationDate = Date()
    }
}
