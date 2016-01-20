//
//  TaskListViewController.swift
//  Realm-TODO
//
//  Created by tpeng on 16/1/20.
//  Copyright © 2016年 tttpeng. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10;
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("listCell")
    cell?.detailTextLabel?.text = "name"
    cell?.textLabel?.text = "title"
    return cell!
  }
  

}
