//
//  Alert.swift
//  MakeathonDemo
//
//  Created by Sergei Kolesin on 2/27/19.
//  Copyright © 2019 Sergei Kolesin. All rights reserved.
//

import UIKit

class Alert {
    
    class func showCommentAlert(in presenter: UIViewController, positiveBlock: (()->())?, negativeBlock: (()->())?) {
        let alert = UIAlertController(title: "Хотите оставить комментарий?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            print("YES")
            if let positiveBlock = positiveBlock {
                positiveBlock()
            }
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (_) in
            print("NO")
            if let negativeBlock = negativeBlock {
                negativeBlock()
            }
        }))
        presenter.present(alert, animated: true, completion: nil)
    }
    
    class func showFeedbackAlert(in presenter: UIViewController, error: Error?) {
        var titleString: String
        if let error = error {
            titleString = "Error: \(error.localizedDescription)"
        } else {
            titleString = "Спасибо за оценку!"
        }
        let alert = UIAlertController(title: titleString, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            print("OK")
            presenter.navigationController?.popToRootViewController(animated: true)
        }))
        presenter.present(alert, animated: true, completion: nil)
    }
    
    class func showLoginErrorAlert(in presenter: UIViewController) {
        let alert = UIAlertController(title: "Неверный логин или пароль", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            print("OK")
        }))
        presenter.present(alert, animated: true, completion: nil)
    }
    
}
