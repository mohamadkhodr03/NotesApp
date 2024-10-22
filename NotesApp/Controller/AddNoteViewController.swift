//
//  AddNoteViewController.swift
//  NotesApp
//
//  Created by Mohamad khaled khodor on 16/10/2024.
//

import UIKit

protocol AddNoteViewControllerDelegate {
    func didAddNote()
}
class AddNoteViewController: UIViewController {
    var noteToEdit: NoteEntity?
    var isNewNote = true
    @IBOutlet weak var addNoteTitleTextField: UITextField!
    @IBOutlet weak var addNoteDescriptionTextView: UITextView!
    @IBOutlet weak var addNoteSaveButton: UIButton!
    
    var delegate: AddNoteViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
        addNoteSaveButton.layer.cornerRadius = 12
        if !isNewNote{
            addNoteTitleTextField.text = noteToEdit?.title
            addNoteDescriptionTextView.text = noteToEdit?.body
        }
    }
    
    @IBAction func onAddNoteSaveButton(_ sender: UIButton) {
        if addNoteTitleTextField.text == "" || addNoteDescriptionTextView.text == "" {
            let alert = UIAlertController(title: "Error", message: "Title and Description must be field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            if isNewNote {
                CoreDataManager.shared.createNote(title: addNoteTitleTextField.text!,
                                                  body: addNoteDescriptionTextView.text!)
            } else if let note = noteToEdit {
                CoreDataManager.shared.updateNote(note: note, newTitle: addNoteTitleTextField.text!, newBody: addNoteDescriptionTextView.text!)
            }
            delegate?.didAddNote()
        
            dismiss(animated: true)
        }
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}
