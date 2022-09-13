//
//  NoteEntityController.swift
//  CoreData-Example
//
//  Created by anas on 06/08/2022.
//

import Foundation
import UIKit
import CoreData

class NoteEntityController{
    var context: NSManagedObjectContext!
    
    init() {
        initializeContext()
    }
    
    func initializeContext(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    func create(note: Note) -> Bool{
        do{
            context.insert(note)
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
    
    func delete(note: Note) -> Bool{
        do{
            context.delete(note)
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    
}
