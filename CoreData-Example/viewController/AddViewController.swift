//
//  AddViewController.swift
//  CoreData-Example
//
//  Created by anas on 03/08/2022.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    var user: User?
    var userEntitManagmentController: UserEntitManagmentController!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Add Contact"
    }
    
    private func initializeView(){
        initializeController()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        performSave()
    }
    
}


extension AddViewController{
    
    private func initializeController(){
        userEntitManagmentController = UserEntitManagmentController()
    }
    
    // VALIDATION
    private func checkData() -> Bool{
        if !nameTextField.text!.isEmpty &&
            !emailTextField.text!.isEmpty &&
            !ageTextField.text!.isEmpty {
            return true
        }else{
            return false
        }
    }
    
    
    private func performSave(){
        if checkData() {
            save()
        }else {
            alertController(title: "Falid Saved", message: "Falid is saved")
        }
    }
    
    // SAVE
    private func save(){
        getUserDate()
        if let _user = user{
            let isCeated = userEntitManagmentController.create(user: _user)
            if isCeated {
                clear()
            }else{
                alertController(title: "Falid", message: "falid is created")
            }
        }
    }
    
    private func getUserDate(){
        user = User(context: userEntitManagmentController.context)
        user?.name = nameTextField.text!
        user?.email = emailTextField.text!
        user?.age = Int16(Int(ageTextField.text!)!)
    }
    
    private func clear(){
        nameTextField.text = ""
        emailTextField.text = ""
        ageTextField.text = ""
    }
    
    
    // ALERT CONTROLLER
    private func alertController(title: String, message: String){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { alertAction in
            print("OK")
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
    
