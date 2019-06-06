//
//  CoreDataStack.swift
//  Tasks
//
//  Created by Jonathan Ferrer on 6/3/19.
//  Copyright © Jonathan Ferrer. All rights reserved.
//

import Foundation
import CoreData


class CoreDataStack {

    static let shared = CoreDataStack()

    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
        var error: Error?
        context.performAndWait {
            do {
                try context.save()
                print("saved to persistent store")
            } catch let saveError {
                error = saveError
            }
        }
        if let error = error { throw error }
    }

    lazy var container: NSPersistentContainer =  {
        let container = NSPersistentContainer(name: "Entry")
        container.loadPersistentStores { (_, error) in

            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }


}
