//
//  CoreDataStorage.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/04/15.
//

import Foundation
import RxSwift
import RxCoreData
import CoreData

class CoreDataStorage : RecordStorageType {
    
    let modelName : String
    
    init(modelName : String) {
        self.modelName = modelName
    }
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var mainContext : NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    @discardableResult
    func createRecord(record: String) -> Observable<Record> {
        let record = Record(record: record)
        
        do {
            _ = try mainContext.rx.update(record)
            return Observable.just(record)
        } catch {
            return Observable.error(error)
        }
    }
    @discardableResult
    func readRecord() -> Observable<[RecordSctionModel]> {
        return mainContext.rx.entities(Record.self, sortDescriptors: [NSSortDescriptor(key: "insertDate", ascending: false)])
            .map { results in [RecordSctionModel(model: 0, items: results)]}
    }
    @discardableResult
    func updateRecord(record: Record, newRecord: String) -> Observable<Record> {
        let updated = Record(pastData: record, newRecord: newRecord)
        
        do {
            _ = try mainContext.rx.update(updated)
            return Observable.just(updated)
        } catch {
            return Observable.error(error)
        }
    }
    @discardableResult
    func deleteRecord(record: Record) -> Observable<Record> {
        do {
            try mainContext.rx.delete(record)
            return Observable.just(record)
        } catch {
            return Observable.error(error)
        }
    }
    
    
}
