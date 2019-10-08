//
//  StorageServices.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/3/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation
import CoreData

protocol GnomesActions {
    func saveGnome(_ id: Int, name: String, thumbnail: String, age: Int, weight: Double, height: Double, hair_color: String, professions: [String], friends: [String])
    func fetchGnomesPopulation(_ descriptors: [NSSortDescriptor]?) -> [Gnome]
    func fetchGnomesByName(_ name: String) -> [Gnome]
    func fetchGnomesByTerm(_ term: String) -> [Gnome]
    func fetchGnomeById(_ id: Int32) -> Gnome?
    func updateGnome(_ updatedGnome: Gnome)
    func deleteGnome(_ id: Int32)
}

public class StorageServices {
    
    static let shared = StorageServices()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Brastlewark")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
