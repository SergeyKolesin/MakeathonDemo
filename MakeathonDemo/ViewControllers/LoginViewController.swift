//
//  LoginViewController.swift
//  MakeathonDemo
//
//  Created by Sergei Kolesin on 2/25/19.
//  Copyright © 2019 Sergei Kolesin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var blockView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        if let username = UserDefaults.standard.object(forKey: "username") as? String,
            let password = UserDefaults.standard.object(forKey: "password") as? String {
            usernameTextField.text = username
            passwordTextField.text = password
            login()
        }
    }
    
    func login() {
        blockView.isHidden = false
        if let username = usernameTextField.text, let password = passwordTextField.text {
            if !username.isEmpty && !password.isEmpty {
                UserDefaults.standard.set(username, forKey: "username")
                UserDefaults.standard.set(password, forKey: "password")
                UserDefaults.standard.synchronize()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    self.performSegue(withIdentifier: "showTopicNavVC", sender: nil)
                    self.blockView.isHidden = true
                }
            } else {
                loginError()
            }
        } else {
            loginError()
        }
    }
    
    @IBAction func pressLogin(_ sender: Any) {
        login()
    }
    
    func loginError() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.blockView.isHidden = true
            self.usernameTextField.text = nil
            self.passwordTextField.text = nil
            Alert.showLoginErrorAlert(in: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTopicNavVC" {
            
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
