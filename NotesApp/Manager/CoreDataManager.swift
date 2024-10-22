//
//  CoreDataManager.swift
//  NotesApp
//
//  Created by Mohamad khaled khodor on 21/10/2024.
//

import CoreData

class CoreDataManager{
    static let shared = CoreDataManager()
    
    
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NotesApp")
        container.loadPersistentStores {storeDescription, error in if let error = error
            {
            fatalError("Unresolved error \(error)")
            
        }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContex() {
        if context.hasChanges{
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror),\(nserror.userInfo)")
            }
        }
    }
    
    func createNote(title: String, body: String){
        let note = NoteEntity(context: context)
        note.title = title
        note.body = body
        
        saveContex()
        
    }
    
    func fetchNotes() -> [NoteEntity] {
        let request = NoteEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func deleteNote(note: NoteEntity){
        context.delete(note)
        saveContex()
    }
    
    func updateNote(note: NoteEntity, newTitle: String, newBody: String) {
            note.title = newTitle
            note.body = newBody
            saveContex()
        }
    
    
    
}


