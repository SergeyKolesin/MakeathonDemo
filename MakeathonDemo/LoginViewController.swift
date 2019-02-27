//
//  LoginViewController.swift
//  MakeathonDemo
//
//  Created by Sergei Kolesin on 2/25/19.
//  Copyright © 2019 Sergei Kolesin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func pressLogin(_ sender: Any) {
        performSegue(withIdentifier: "showTopicNavVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTopicNavVC" {
            
        }
    }
}
