//
//  ChooseShopViewController.swift
//  MakeathonDemo
//
//  Created by Sergei Kolesin on 2/27/19.
//  Copyright © 2019 Sergei Kolesin. All rights reserved.
//

import UIKit

class ChooseShopViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let shops: [String] = ["Пятерочка", "Ашан", "Магнит"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func pressLogout(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTopicsVC" {
            guard let vc = segue.destination as? ChooseTopicViewController else {
                return
            }
            guard let shop = sender as? String else {
                return
            }
            vc.shop = shop
        }
    }
}

extension ChooseShopViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath)
        let shop = shops[indexPath.row]
        cell.textLabel?.text = shop
        return cell
    }
}

extension ChooseShopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        performSegue(withIdentifier: "showTopicsVC", sender: shops[indexPath.row])
    }
}