//
//  DataProvider.swift
//  NoteTakingApp
//
//  Created by Хайдар Даукаев on 01.02.2024.
//

import UIKit
import CoreData

public final class DataProvider: NSObject {
    public static let shared = DataProvider()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    public func createNote(_ id: UUID, text: String, isFav: Bool) {
        guard let noteEntityDescription = NSEntityDescription.entity(forEntityName: "Note", in: context) else { return }
        let note = Note(entity: noteEntityDescription, insertInto: context)
        note.id = id
        note.text = text
        note.isFav = isFav
        
        appDelegate.saveContext()
    }
    
    public func fetchNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            return try context.fetch(fetchRequest) as! [Note]
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    public func fetchNote(with id: UUID) -> Note? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try? context.fetch(fetchRequest) as? [Note] else {
                return nil
            }
            return notes.first(where: { $0.id == id})
        }
    }
    
    public func updateNote(with id: UUID, newText: String, isFav: Bool) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try? context.fetch(fetchRequest) as? [Note],
                  let note = notes.first(where: { $0.id == id }) else { return }
            
            note.text = newText
            note.isFav = isFav
        }
        
        appDelegate.saveContext()
    }
    
    public func deleteNote(with id: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try? context.fetch(fetchRequest) as? [Note],
                  let note = notes.first(where: { $0.id == id }) else {
                return
            }
            context.delete(note)
        }
        
        appDelegate.saveContext()
    }
    
    public func deleteAllNotes() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do {
            let notes = try? context.fetch(fetchRequest) as? [Note]
            notes?.forEach { context.delete($0) }
        }
    }
}
