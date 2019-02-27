//
//  CommentViewController.swift
//  MakeathonDemo
//
//  Created by Sergei Kolesin on 2/27/19.
//  Copyright © 2019 Sergei Kolesin. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
    
    @IBOutlet weak var commentTextField: UITextField!
    var shop: String!
    var topicUuid: String!
    var value: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextField.delegate = self
    }
    
    @IBAction func pressSendFeedback(_ sender: Any) {
        commentTextField.resignFirstResponder()
        NetworkManager.postFeedback(entityName: shop, topicUuid: topicUuid, qualityLevelGrade: value, comment: commentTextField.text) { (_, error) in
            Alert.showFeedbackAlert(in: self, error: error)
        }
    }
}

extension CommentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
