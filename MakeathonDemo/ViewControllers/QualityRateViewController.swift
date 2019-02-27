//
//  QualityRateViewController.swift
//  MakeathonDemo
//
//  Created by Sergei Kolesin on 2/25/19.
//  Copyright © 2019 Sergei Kolesin. All rights reserved.
//

import UIKit

class QualityRateViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    var shop: String!
    
    static let titleLabelString = "Пожалуйста, оцените %@ в магазине '%@'"
    var titleString: String?
    
    var topic: Topic! {
        didSet {
            titleString = String(format:QualityRateViewController.titleLabelString, topic.name.lowercased(), shop)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = titleString
    }
    
}

extension QualityRateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topic.qualityLevels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QualityRateCell", for: indexPath)
        cell.textLabel?.text = topic.qualityLevels[indexPath.row].qualityLevelName
        return cell
    }
}

extension QualityRateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        
        
        let alert = UIAlertController(title: "Хотите оставить комментарий?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            print("YES")
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (_) in
            print("NO")
            NetworkManager.postFeedback(entityName: self.shop, topicUuid: self.topic.uuid, qualityLevelGrade: self.topic.qualityLevels[indexPath.row].qualityLevelGrade, comment: nil, completion: { (_, error) in
                var titleString: String
                if let error = error {
                    titleString = "Error: \(error.localizedDescription)"
                } else {
                    titleString = "Спасибо за оценку!"
                }
                let alert = UIAlertController(title: titleString, message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    print("OK")
                }))
                self.present(alert, animated: true, completion: nil)
            })
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
