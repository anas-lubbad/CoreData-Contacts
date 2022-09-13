//
//  UserEntityManagementController.swift
//  CoreData-Example
//
//  Created by anas on 31/07/2022.
//

import Foundation
import CoreData
import UIKit

class UserEntitManagmentController{
    var context: NSManagedObjectContext!
    
    init(){
        ManageController()
    }
    
    func ManageController(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        context = appDelegate.persistentContainer.viewContext
    }
    
    // Create
    func create(user: User) -> Bool{
        do{
            context.insert(user)
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
    // Read
    func read() -> [User]?{
        do{
        let fetchRequest: NSFetchRequest = User.fetchRequest()
        return try context.fetch(fetchRequest)
        }catch let error as NSError{
            print(error)
        }
        return nil
    }
    
    // Update
    func update(email: String, user: User) -> Bool{
        let fetchRequest: NSFetchRequest = User.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate.init(format: "email = %@", email)
        do{
            let userFetch = try context.fetch(fetchRequest)
            if !userFetch.isEmpty{ // userFetch = 1
                // let _user = userFetch[0]
                let user = userFetch.first
                if let _user = user {
                    _user.setValue(user?.name, forKey: "name")
                    _user.setValue(user?.email, forKey: "email")
                    _user.setValue(user?.age, forKey: "age")
                    try context.save()
                    return true
                }
                
            }else{ // userFetch = 0
                print("Email this is nil !!")
            }
            
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
    // Delete
    func delete(email: String) -> Bool{
        let fetchRequst: NSFetchRequest = User.fetchRequest()
        fetchRequst.fetchLimit = 1
        fetchRequst.predicate = NSPredicate.init(format: "email = %@", email)
        do{
            let userFetch = try context.fetch(fetchRequst)
            if !userFetch.isEmpty {
                if let _user = userFetch.first{
                    context.delete(_user)
                    try context.save()
                    return true
                }
            }
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
}
