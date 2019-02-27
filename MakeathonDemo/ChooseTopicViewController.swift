//
//  ChooseTopicViewController.swift
//  MakeathonDemo
//
//  Created by Sergei Kolesin on 2/27/19.
//  Copyright © 2019 Sergei Kolesin. All rights reserved.
//

import UIKit

class ChooseTopicViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var topics = [Topic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkManager.getTopics { (topics, error) in
            if let error = error {
                let alert = UIAlertController(title: "Error: \(error.localizedDescription)", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    print("OK")
                }))
                self.present(alert, animated: true, completion: nil)
            } else if let topics = topics {
                self.topics = topics
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQualityRateVC" {
            guard let nav = segue.destination as? UINavigationController else {
                return
            }
            guard let vc = nav.viewControllers.first as? QualityRateViewController else {
                return
            }
            guard let topic = sender as? Topic else {
                return
            }
            vc.topic = topic
        }
    }
}

extension ChooseTopicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath)
        let topic = topics[indexPath.row]
        cell.textLabel?.text = topic.name
        return cell
    }
}

extension ChooseTopicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        performSegue(withIdentifier: "showQualityRateVC", sender: topics[indexPath.row])
    }
}
