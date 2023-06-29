//
//  CoreDataStack.swift
//  Movie+
//
//  Created by Ikmal Azman on 29/06/2023.
//

import Foundation
import CoreData

enum StorageType {
    case persistent
    case inMemory
}

enum ModelName : String {
    case MoviePlus
}

final class CoreDataStack {
    
    let modelName : ModelName
    let storageType : StorageType
    lazy var context : NSManagedObjectContext = storeContainer.viewContext
    
    private lazy var storeContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName.rawValue)
        
        if storageType == .inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(string: "/dev/null")
            container.persistentStoreDescriptions = [description]
        }
        
        container.loadPersistentStores { _, error in
            if let error = error as? NSError {
                fatalError("Error load persistent stores, \(error) : \(error.userInfo)")
            }
        }
        return container
    }()
    
    init(modelName: ModelName , storageType: StorageType = .persistent) {
        self.modelName = modelName
        self.storageType = storageType
    }
    
    func saveContext() {
        guard context.hasChanges else {return}
        do {
            try context.save()
        } catch {
            print("Error saving context into Core Data : \(error.localizedDescription)")
        }
    }
    
    func fetchContext<T:NSManagedObject>(of type : T.Type,
                                         with descriptors : [NSSortDescriptor],
                                         _ completion : @escaping ([T])->Void) {
        let object: NSFetchRequest<T> = NSFetchRequest<T>(entityName: "\(T.self)")
        object.sortDescriptors = descriptors
        
        do {
            let results = try context.fetch(object)
            completion(results)
        } catch {
            print("Error load context for type \(type), \(error.localizedDescription)")
        }
    }
    
}
