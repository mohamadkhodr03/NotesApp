//
//  NoteTableViewCell.swift
//  NotesApp
//
//  Created by Mohamad khaled khodor on 16/10/2024.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    @IBOutlet weak var noteTittleLabel: UILabel!
    @IBOutlet weak var noteDescriptionLabel: UILabel!
    @IBOutlet weak var noteBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        noteBackgroundView.layer.cornerRadius = 12
        
    }

    func setup(note: NoteEntity) {
        noteTittleLabel.text = note.title
        noteDescriptionLabel.text = note.body
        
    }
    
}
