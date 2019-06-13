//
//  TodoItemColor.swift
//  TodoList
//
//  Created by epita on 12/06/2019.
//  Copyright © 2019 epita. All rights reserved.
//

import UIKit

class TodoItemColor: NSObject {
    var value: UIColor
    var name: String
    
    init(name:String, value:UIColor) {
        self.name = name
        self.value = value
    }
    
    static let colors = [
        TodoItemColor.white,
        TodoItemColor(name:"Red", value:UIColor(red:1.0,green:0.7,blue:0.7,alpha:1.0)),
        TodoItemColor(name:"Green", value:UIColor(red:0.5,green:0.9,blue:0.75,alpha:1.0)),
        TodoItemColor(name:"Blue", value:UIColor(red:0.5,green:0.65,blue:1.0,alpha:1.0)),
        TodoItemColor(name:"Yellow", value:UIColor(red:1.0,green:1.0,blue:0.6,alpha:1.0))
    ]
    
    static let white = TodoItemColor(name:"white", value:UIColor.white)
    
    static func index(color: TodoItemColor?) -> Int? {
        if let index = colors.firstIndex(where: { $0.name == color?.name }) {
            return index
        }
        return nil
    }
}
