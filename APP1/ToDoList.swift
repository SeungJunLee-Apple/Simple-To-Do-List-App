//
//  ToDoList.swift
//  USA
//
//  Created by SeungJun Lee on 4/9/20.
//  Copyright © 2020 SeungJun Lee. All rights reserved.
//

import Foundation
import CoreData

public class ToDoList:NSManagedObject, Identifiable {
    @NSManaged public var createdAt:Date?
    @NSManaged public var title:String?
    @NSManaged public var taskIsDone:Bool
}

extension ToDoList {
    
    static func getAllToDoLists() -> NSFetchRequest<ToDoList> {
        let request:NSFetchRequest<ToDoList> = ToDoList.fetchRequest() as!
        NSFetchRequest<ToDoList>
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
    
    static func getAllToDoLists2() -> NSFetchRequest<ToDoList> {
        
        let request2:NSFetchRequest<ToDoList> = ToDoList.fetchRequest() as!
        NSFetchRequest<ToDoList>
        
        
        let sortDescriptor = NSSortDescriptor(key: "coreDataMinute", ascending: true)
        request2.sortDescriptors = [sortDescriptor]
        
        return request2
    }
}
