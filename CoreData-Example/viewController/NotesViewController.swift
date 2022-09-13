//
//  NotesViewController.swift
//  CoreData-Example
//
//  Created by anas on 06/08/2022.
//

import UIKit

class NotesViewController: UIViewController {
    
    @IBOutlet weak var notesTableView: UITableView!
    
    var noteControler: NoteEntityController?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }
    
    private func initializeView(){
        initializeTableView()
    }
    
}


//MARK: - UITableView
extension NotesViewController: UITableViewDataSource,UITableViewDelegate{
    
    private func initializeTableView(){
        noteControler = NoteEntityController()
        notesTableView.delegate = self
        notesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.notes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath) as! NotesTableViewCell
        let note = user?.notes?.allObjects[indexPath.row] as! Note
        cell.setData(note: note)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete){
            if let _noteController = noteControler{
                let note = user?.notes?.allObjects[indexPath.row] as! Note
                let isDeleted = _noteController.delete(note: note)
                if isDeleted{
                    //notesTableView.reloadData()
                    notesTableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
        
    }
    
}
