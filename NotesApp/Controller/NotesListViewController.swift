//
//  NotesListViewController.swift
//  NotesApp
//
//  Created by Mohamad khaled khodor on 16/10/2024.
//

import UIKit

class NotesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddNoteViewControllerDelegate {
    
    @IBOutlet weak var tabelView: UITableView!
    
    var notes = [NoteEntity]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.delegate = self
        tabelView.dataSource = self
        tabelView.separatorStyle = .none
        tabelView.estimatedRowHeight = 100
        tabelView.rowHeight = UITableView.automaticDimension
        title = "Notes"
        notes = CoreDataManager.shared.fetchNotes()
        let nib = UINib(nibName: "NoteTableViewCell", bundle: nil)
        tabelView.register(nib, forCellReuseIdentifier: "NoteTableViewCell")
        
    }
    

    
    @IBAction func onAddNoteButtonTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "AddNoteViewController") as! AddNoteViewController
        destination.delegate = self
        present(destination, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as! NoteTableViewCell
        
        
        cell.setup(note: notes[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete // Allows swipe-to-delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete Note", message: "Are you sure you want to delete this note?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                // Fetch the object to delete
                let noteToDelete = CoreDataManager.shared.fetchNotes()[indexPath.row]
                
                // Delete the object from Core Data
                CoreDataManager.shared.deleteNote(note: noteToDelete)
                
                // Update the table view
                self.notes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "AddNoteViewController") as! AddNoteViewController
        destination.noteToEdit = notes[indexPath.row]
        destination.isNewNote = false
        destination.delegate = self
        present(destination, animated: true)
        
    }
    func didAddNote() {
        notes = CoreDataManager.shared.fetchNotes()
        tabelView.reloadData()
    }
    
}
