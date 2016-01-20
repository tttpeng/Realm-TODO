//
//  Task.swift
//  Realm-TODO
//
//  Created by tpeng on 16/1/20.
//  Copyright © 2016年 tttpeng. All rights reserved.
//

import RealmSwift
import Foundation

class Task: Object {
  
  dynamic var name = ""
  dynamic var createdAt = NSDate()
  dynamic var notes = ""
  dynamic var isConpleted = false
  
  
}

class TaskList: Object {
  dynamic var name = ""
  dynamic var createdAt = NSDate()
  let tasks = List<Task>()
}
