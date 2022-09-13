//
//  NoteViewController.swift
//  CoreData-Example
//
//  Created by anas on 06/08/2022.
//

import UIKit
import SCLAlertView

class NoteViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var switchOutlet: UISwitch!
    
    var noteController: NoteEntityController?
    
    var user: User?
    var note: Note?
    var isCreate: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }
    
    private func initializeView(){
        initializeController()
        userNameLabel.text = "This is for user: \(user?.name ?? "") | Notes: \(user?.notes?.count ?? 0)"
    }
    
    @IBAction func saveAction(_ sender: Any) {
        performSave()
    }
    
    @IBAction func switchAction(_ sender: Any) {
    }
    
}

extension NoteViewController{
    
    private func initializeController(){
        noteController = NoteEntityController()
    }
    
    private func performSave(){
        if checkData() {
            isCreate ? save() : update()
        }
    }
    
    private func checkData() -> Bool{
        if isCreate{
            if !titleTextField.text!.isEmpty{
                return true
            }else{
                SCLAlertView().showError("Failed", subTitle: "Please, enter note title..")
            }
        }
        return false
    }
    
    
    private func save(){
        getNoteData()
        if let _noteController = noteController, let _note = note{
            let isCreated = _noteController.create(note: _note)
            //isCreated ? print("SUCCESS") : print("FALID")
            if isCreated {
                SCLAlertView().showInfo("Success", subTitle: "Note Created")
            }else{
                
            }
            //dismiss(animated: true, completion: nil)
        }
    }
    
    private func update(){}
    
    private func getNoteData(){
        if isCreate{
            note = Note(context: (noteController?.context)!)
            note?.user = user // -> اضافة اليوسر على النوت
            note?.titlte = titleTextField.text
            note?.status = switchOutlet.isOn
            
            //user?.notes = NSSet.init(array: [note]) // -> اضافة نوت على اليوسر
        }
    }
}
