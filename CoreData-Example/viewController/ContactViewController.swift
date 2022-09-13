//
//  ContactViewController.swift
//  CoreData-Example
//
//  Created by anas on 03/08/2022.
//

import UIKit


class ContactViewController: UIViewController {

    @IBOutlet weak var contactTableView: UITableView!
    
    var users: [User] = [User]()
    var userEntitManagmentController: UserEntitManagmentController?
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initielaizeView()
        //print(filePath)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Contacts"
        getContact()
    }
    
    private func initielaizeView(){
        userEntitManagmentController = UserEntitManagmentController()
        initielaizeTableView()
        //getContact()
    }
    
    private func getContact(){
        users = userEntitManagmentController!.read()!
        contactTableView.reloadData()
    }
    
}

//MARK: - ContactProtocol
extension ContactViewController: ContactProtocol{
    
    func viewNote(user: User) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
        vc.user = user
        present(vc, animated: true, completion: nil)
    }
    
    func newNote(user: User) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NoteViewController") as! NoteViewController
        vc.isCreate = true
        vc.user = user
        present(vc, animated: true, completion: nil)
    }
    
    
}


//MARK: - UITableView
extension ContactViewController: UITableViewDataSource,UITableViewDelegate{
    
    private func initielaizeTableView(){
        contactTableView.dataSource = self
        contactTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("this is email",users[indexPath.row].email ?? "")
        // push to update
        let vc = storyboard?.instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
        vc.user = users[indexPath.row]
        present(vc, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
        cell.setData(user: users[indexPath.row])
        cell.contactProtocol = self
        return cell
    }
    
    // DELETE SWIPE
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete){
            if let _email = users[indexPath.row].email{
                let isDelete = userEntitManagmentController!.delete(email: _email) // delete coreData
                if isDelete{
                    users.remove(at: indexPath.row) // delete array
                    contactTableView.deleteRows(at: [indexPath], with: .automatic) // delete tableView
                    print("Deleted")
                }else{
                    print("Not deleted")
                }
            }
            
        }
        
        // STEPS DELETE CELL
        // 1) DELETE COREDATA
        // 2) DELETE ARRAY
        // 3) DELETE TABLEVIEW
        
    }
    
}
