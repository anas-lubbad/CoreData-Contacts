//
//  NotesTableViewCell.swift
//  CoreData-Example
//
//  Created by anas on 06/08/2022.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var noteAddedLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(note: Note){
        noteAddedLabel.text = note.titlte
        statusLabel.text = String(describing: note.status)
    }

}

// describing:
// Int => String
// Bool => String
