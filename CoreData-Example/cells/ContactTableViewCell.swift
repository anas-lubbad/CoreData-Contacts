//
//  ContactTableViewCell.swift
//  CoreData-Example
//
//  Created by anas on 03/08/2022.
//

import UIKit

protocol ContactProtocol{
    func newNote(user: User)
    func viewNote(user: User)
}

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLbel: UILabel!
    
    var contactProtocol: ContactProtocol?
    var user: User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(user: User){
        self.user = user
        nameLabel.text = user.name
        emailLbel.text = user.email
    }
    
    @IBAction func addNoteAction(_ sender: Any) {
        if let _contactProtocol = contactProtocol, let _user = user{
            _contactProtocol.newNote(user: _user)
        }
    }
    
    @IBAction func viewNotesAction(_ sender: Any) {
        if let _contactProtocol = contactProtocol, let _user = user{
            _contactProtocol.viewNote(user: _user)
        }
    }
    
    
}
