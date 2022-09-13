//
//  SettingViewController.swift
//  CoreData-Example
//
//  Created by anas on 03/08/2022.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Setting"
    }


}
