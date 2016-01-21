//
//  TaskListViewController.swift
//  Realm-TODO
//
//  Created by tpeng on 16/1/20.
//  Copyright © 2016年 tttpeng. All rights reserved.
//

import UIKit
import RealmSwift


class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var lists : Results<TaskList>!
    var currentCreatAction:UIAlertAction!
    
    @IBOutlet weak var taskListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.readTasksAndUpdateUI()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if let listTasks = lists {
            return listTasks.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell")
        let list = lists[indexPath.row]
        cell?.textLabel?.text = list.name
        cell?.detailTextLabel?.text = "\(list.tasks.count) 个目标"
        return cell!
    }
    
    
    func readTasksAndUpdateUI(){
        lists = uiRealm.objects(TaskList)
        taskListTableView.reloadData()
    }
    
    
    @IBAction func didClickOnEditButton(sender: UIBarButtonItem) {
        
        taskListTableView.editing = true
    }
    @IBAction func didClickAddButton(sender: UIBarButtonItem) {
        
        let title = "创建目标列表"
        let doTitle = "创建"
        
        
        let alertController = UIAlertController(title: title, message: "给你的目标列表起个名字", preferredStyle: .Alert)
        
        
        let createActon = UIAlertAction(title: doTitle, style: .Default) { (action) -> Void in
            
            let listName = alertController.textFields?.first?.text
            
            
            let newTaskList = TaskList()
            newTaskList.name = listName!
            
            
            try! uiRealm.write({ () -> Void in
                uiRealm.add(newTaskList)
                self.readTasksAndUpdateUI()
            })
        }
        
        alertController.addAction(createActon)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        createActon.enabled  = false
        self.currentCreatAction = createActon
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "目标列表名字"
            textField.addTarget(self, action: "listNameFieldDidChange:", forControlEvents: .EditingChanged)
            
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    func listNameFieldDidChange(textField: UITextField) {
        self.currentCreatAction.enabled = textField.text?.characters.count > 0
    }
    
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style:UITableViewRowActionStyle.Destructive, title: "删除") { (deleteAction, indexPath) -> Void in
            
            let listToBeDeleted = self.lists[indexPath.row]
            try! uiRealm.write({ () -> Void in
                uiRealm.delete(listToBeDeleted)
                self.readTasksAndUpdateUI()
            })
        }
        return [deleteAction]
    }
    
}
