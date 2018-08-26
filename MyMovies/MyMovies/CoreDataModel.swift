//
//  CoreDataModel.swift
//  MyMovies
//
//  Created by Carolyn Lea on 8/25/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack
{
    static let shared = CoreDataStack()
    
    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws
    {
        var error: Error?
        
        context.performAndWait {
            do {
                try context.save()
            } catch let saveError {
                error = saveError
            }
        }
        if let error = error { throw error }
    }
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Movies")
        container.loadPersistentStores { (_, error) in
            if let error = error
            {
                fatalError("Failed to load persistent store: \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
}