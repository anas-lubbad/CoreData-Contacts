//
//  UpdateViewController.swift
//  CoreData-Example
//
//  Created by anas on 04/08/2022.
//

import UIKit

class UpdateViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    var userEntitManagmentController: UserEntitManagmentController?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }
    
    @IBAction func updateAction(_ sender: Any) {
        performUpdate()
    }
    
    private func initializeView(){
        userEntitManagmentController = UserEntitManagmentController()
        initializeController()
    }
    
}

extension UpdateViewController{
    
    private func initializeController(){
        setUserData()
        getUserData()
    }
    
    // View DATA
    private func setUserData(){
        nameTextField.text = user?.name
        emailTextField.text = user?.email
        ageTextField.text = String(describing: user?.age)
        //describing ==> تحويل من int -> string
    }
    
    
    private func performUpdate(){
        if checkData() {
            update()
        }
    }
    
    
    // VALIDATION
    private func checkData() -> Bool{
        if !nameTextField.text!.isEmpty &&
            !emailTextField.text!.isEmpty &&
            !ageTextField.text!.isEmpty {
            return true
        }else{
            alertController(title: "Falid", message: "fill filds")
            return false
        }
    }
    
    // UPDATE USER
    private func update(){
        getUserData()
        if let _userEntitManagmentController = userEntitManagmentController{
            if let _user = user{
                let isUpdated = _userEntitManagmentController.update(email: user?.email ?? "No Update Email", user: _user)
                if isUpdated {
                   // clear()
                    dismiss(animated: true, completion: nil)
                    //alertController(title: "Success", message: "update is success")
                }
                alertController(title: "Falid", message: "update is falid")
            }
        }
    }
    
    // GET DATA
    private func getUserData(){
        if let _user = user{
            _user.name = nameTextField.text
            _user.email = emailTextField.text
            _user.age = Int16(Int(ageTextField.text!) ?? 0)
        }
    }
    
    // CLEAR
    private func clear(){
        nameTextField.text = ""
        emailTextField.text = ""
        ageTextField.text = ""
    }
    
    
    //ALERT
    private func alertController(title: String?, message: String?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { alertAction in
            print("DONE!")
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
