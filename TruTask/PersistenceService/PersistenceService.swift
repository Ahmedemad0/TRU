//
//  PersistenceService.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//


import CoreData

final class PersistenceService {
    
    // MARK: - Singleton Instance
    static let shared = PersistenceService()
    
    private init() {} // Prevents external initialization
    
    // MARK: - Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        // Replace "ModelName" with the name of your .xcdatamodeld file
        let container = NSPersistentContainer(name: "LocalProducts")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // Handle error appropriately in production apps
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Managed Object Context
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Save Context
    func saveContext() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    // MARK: - Generic CRUD Operations
    
    /// Fetches objects of a given type with optional predicate and sort descriptors.
    /// - Parameters:
    ///   - type: The NSManagedObject subclass to fetch.
    ///   - predicate: An optional predicate to filter results.
    ///   - sortDescriptors: Optional sort descriptors for the fetch request.
    /// - Returns: An array of objects of type T, or nil if the fetch fails.
    func fetchObjects<T: NSManagedObject>(ofType type: T.Type,
                                            predicate: NSPredicate? = nil,
                                            sortDescriptors: [NSSortDescriptor]? = nil) -> [T]? {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        do {
            let data = try context.fetch(request)
            print("Data: \(data)")
            return data
        } catch {
            print("Fetch error for \(type): \(error)")
            return nil
        }
    }
    
    /// Creates a new managed object of the specified type.
    /// - Parameter type: The NSManagedObject subclass to create.
    /// - Returns: A new instance of type T.
    func createObject<T: NSManagedObject>(ofType type: T.Type) -> T {
        let entityName = String(describing: type)
        guard let object = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? T else {
            fatalError("Unable to create object of type \(entityName)")
        }
        return object
    }
    
    /// Deletes the specified managed object.
    /// - Parameter object: The NSManagedObject instance to delete.
    func deleteObject(_ object: NSManagedObject) {
        context.delete(object)
    }
    
    /// Deletes all objects for every entity in the persistent store.
      func deleteAllData() {
          let context = persistentContainer.viewContext
          let coordinator = persistentContainer.persistentStoreCoordinator

          // Loop through all entities in your model
          for entity in persistentContainer.managedObjectModel.entities {
              guard let name = entity.name else { continue }
              
              // Create a fetch request for the entity
              let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
              
              // Create the batch delete request
              let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
              
              do {
                  // Execute the batch delete
                  try coordinator.execute(deleteRequest, with: context)
              } catch {
                  print("Failed to delete data for \(name): \(error)")
              }
          }
      }
}
