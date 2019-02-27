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
    
    var topic: Topic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        NetworkManager.postFeedback(qualityLevelGrade: indexPath.row + 1, topicUuid: "blabla", latitude: -33.73, longitude: 151.25) { (date, error) in
            DispatchQueue.main.async {
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
            }
        }
    }
}
