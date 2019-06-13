//
//  TodoListTableViewController.swift
//  TodoList
//
//  Created by epita on 12/06/2019.
//  Copyright © 2019 epita. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    
    var todoItems = [TodoItem]()
    var editedTodoItem: TodoItem?
    var editionIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isEditing = true
        loadInitialData()
    }
    
    func loadInitialData() {
        todoItems.append(TodoItem(value: "Clean my room", color: TodoItemColor.white))
        todoItems.append(TodoItem(value: "Cook dinner", color: TodoItemColor.white))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    @IBAction func unwindToList(_ segue: UIStoryboardSegue) {
        if let source = segue.source as? AddTodoItemViewController {
            if let item = source.todoItem {
                if !source.edition {
                    self.todoItems.append(item)
                }
                else if let index = source.editionIndex {
                    self.todoItems[index] = item
                }
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListPrototypeCell", for: indexPath)
        if indexPath.row < todoItems.count {
            let todoItem = todoItems[indexPath.row]
            cell.textLabel?.text = todoItem.value
            if let color = todoItem.color {
                cell.backgroundColor = color.value
            }
            if (todoItem.completed) {
                cell.accessoryType = .checkmark
            }
            else {
                cell.accessoryType = .none
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row < todoItems.count {
            let todoItem = todoItems[indexPath.row]
            todoItem.completed = !todoItem.completed
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(
            style: .normal,
            title: "Edit",
            handler: {
                (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                self.editionIndex = indexPath.row
                self.editedTodoItem = self.todoItems[indexPath.row]
                self.performSegue(withIdentifier: "TodoListToEditTodoItem", sender: self)
                success(true)
            }
        )
        editAction.backgroundColor = UIColor(red:0.65, green:0.8, blue:1.0, alpha: 1.0)
        
        let deleteAction = UIContextualAction(
            style: .normal,
            title: "Delete",
            handler: {
                (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                self.todoItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                success(true)
            }
        )
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TodoListToEditTodoItem" {
            let navigationController = segue.destination as? UINavigationController
            let viewController = navigationController?.viewControllers[0]
            if let todoItemViewController = viewController as? AddTodoItemViewController {
                todoItemViewController.todoItem = editedTodoItem
                todoItemViewController.edition = true
                todoItemViewController.editionIndex = editionIndex
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = todoItems[sourceIndexPath.row]
        todoItems.remove(at: sourceIndexPath.row)
        todoItems.insert(movedObject, at: destinationIndexPath.row)
    }
}
