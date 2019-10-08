//
//  StorageServices+GnomeActions.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/4/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation
import CoreData

extension StorageServices: GnomesActions {
    
    func saveGnome(_ id: Int, name: String, thumbnail: String, age: Int, weight: Double, height: Double, hair_color: String, professions: [String], friends: [String]) {
        let managedContext = self.persistentContainer.viewContext
        let gnome = NSEntityDescription.insertNewObject(forEntityName: "Gnome", into: managedContext) as! Gnome
        gnome.id = Int32(id)
        gnome.name = name
        gnome.thumbnail = thumbnail
        gnome.age = Int32(age)
        gnome.weight = weight
        gnome.height = height
        gnome.hair_color = hair_color
        gnome.professions = professions as [String]
        gnome.friends = friends as [String]
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchGnomesPopulation(_ descriptors: [NSSortDescriptor]?) -> [Gnome] {
        let managedContext = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Gnome>(entityName: "Gnome")
        fetchRequest.sortDescriptors = descriptors
        var people: [Gnome] = []
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return people
    }
    
    func fetchGnomesByName(_ name: String) -> [Gnome] {
        let managedContext = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Gnome>(entityName: "Gnome")
        fetchRequest.predicate = NSPredicate(format: "name = '\(name)'")
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func fetchGnomesByTerm(_ term: String) -> [Gnome] {
        let managedContext = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Gnome>(entityName: "Gnome")
        fetchRequest.predicate = NSPredicate(format: "name contains[c] '\(term)'")
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func fetchGnomeById(_ id: Int32) -> Gnome? {
        let managedContext = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Gnome>(entityName: "Gnome")
        fetchRequest.predicate = NSPredicate(format: "id = '\(id)'")
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people.last
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func updateGnome(_ updatedGnome: Gnome) {
        if let oldGnome = fetchGnomeById(updatedGnome.id) {
            oldGnome.name = updatedGnome.name
            oldGnome.thumbnail = updatedGnome.thumbnail
            oldGnome.age = updatedGnome.age
            oldGnome.weight = updatedGnome.weight
            oldGnome.height = updatedGnome.height
            oldGnome.hair_color = updatedGnome.hair_color
            oldGnome.professions = updatedGnome.professions
            oldGnome.friends = updatedGnome.friends
            let managedContext = self.persistentContainer.viewContext
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func deleteGnome(_ id: Int32) {
        let managedContext = self.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Gnome> = Gnome.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id==\(id)")
        do {
            let objects = try managedContext.fetch(fetchRequest)
            if let objectToDelete = objects.last {
                managedContext.delete(objectToDelete)
                try managedContext.save()
            } else {
                print("Could not delete.")
            }
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
}
