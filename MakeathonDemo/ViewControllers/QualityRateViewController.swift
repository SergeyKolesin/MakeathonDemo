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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCommentVC" {
            guard let vc = segue.destination as? CommentViewController else {
                return
            }
            guard let value = sender as? Int else {
                return
            }
            vc.shop = shop
            vc.value = value
            vc.topicUuid = topic.uuid
        }
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
        Alert.showCommentAlert(in: self, positiveBlock: { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.performSegue(withIdentifier: "showCommentVC", sender: strongSelf.topic.qualityLevels[indexPath.row].qualityLevelGrade)
        }, negativeBlock: { [weak self] in
            guard let strongSelf = self else {return}
            NetworkManager.postFeedback(entityName: strongSelf.shop, topicUuid: strongSelf.topic.uuid, qualityLevelGrade: strongSelf.topic.qualityLevels[indexPath.row].qualityLevelGrade, comment: nil, completion: { (_, error) in
                Alert.showFeedbackAlert(in: strongSelf, error: error)
            })
        })
    }
}
