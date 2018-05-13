//
//  ViewController.swift
//  EmployeeSelfService
//
//  Created by Satesh Ramadas on 5/12/18.
//  Copyright © 2018 GreenBins. All rights reserved.
//

import UIKit

class LogonViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOnButtonPressed(_ sender: Any) {
    }
    
}

