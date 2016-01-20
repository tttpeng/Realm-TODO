//
//  ViewController.swift
//  Realm-TODO
//
//  Created by tpeng on 16/1/20.
//  Copyright © 2016年 tttpeng. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    
    let taskListA = TaskList()
    taskListA.name = "iPeta"
    
    let wish1 = Task()
    wish1.name = "iPhone 6s"
    wish1.notes = "128GB, Gold"
    let wish2 = Task(value: ["name":"Game Console", "notes": "Playstation 4, 1 TB"])
    
    let wish3 = Task(value: ["Car",NSDate(),"Auto R8",false])
    
    taskListA.tasks.appendContentsOf([wish1,wish2,wish3])
    
    let taskListB = TaskList(value: ["MoviesList", NSDate(), [["The Martian", NSDate(), "", false], ["The Maze Runner", NSDate(), "", true]]])

    

    
    do {
      try uiRealm.write({ () -> Void in
        uiRealm.add([taskListA,taskListB])
      })
    } catch {
      print("error")
    }
    
    
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

