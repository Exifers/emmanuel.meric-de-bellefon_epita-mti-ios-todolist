//
//  AddTodoItemViewController.swift
//  TodoList
//
//  Created by epita on 12/06/2019.
//  Copyright © 2019 epita. All rights reserved.
//

import UIKit

class AddTodoItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var todoItem: TodoItem?
    var colors: [TodoItemColor] = TodoItemColor.colors
    var selectedColor: TodoItemColor?
    var edition: Bool = false
    var editionIndex: Int?
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var colorsPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.colorsPickerView.delegate = self
        self.colorsPickerView.dataSource = self
        
        if let item = todoItem {
            selectedColor = item.color
            colorsPickerView.selectRow(
                TodoItemColor.index(color: selectedColor) ?? 0,
                inComponent: 0,
                animated: false
            )
            textField.text = item.value
        }
        else {
            selectedColor = colors[0]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? UIBarButtonItem, sender == doneButton {
            if let text = textField.text, text.count > 0 {
                if let color = selectedColor {
                    todoItem = TodoItem(value: text, color: color)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedColor = colors[row]
    }
}
