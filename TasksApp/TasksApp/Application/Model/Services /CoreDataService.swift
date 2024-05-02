//
//  CoreDataService.swift
//  TasksApp
//
//  Created by user on 25.04.2024.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol: AnyObject {
    func fetchCountries() throws -> [CountryManagedObject]
    func save(block: (NSManagedObjectContext) throws -> Void)
}

final class CoreDataService {
    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "CountryDataModel")
        persistentContainer.loadPersistentStores { _, error in
            guard let error else { return }
            print(error)
        }
        return persistentContainer
    }()
    
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}

extension CoreDataService: CoreDataServiceProtocol {
    func fetchCountries() throws -> [CountryManagedObject] {
        let fetchRequest = CountryManagedObject.fetchRequest()
        return try viewContext.fetch(fetchRequest)
    }

    func save(block: (NSManagedObjectContext) throws -> Void) {
        let backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.performAndWait {
            do {
              try block(backgroundContext)
                if backgroundContext.hasChanges {
                    try backgroundContext.save()
                }
            } catch {
                print(error)
            }
        }
    }
}
