//
//  NetworkManager.swift
//  MakeathonDemo
//
//  Created by Sergei Kolesin on 2/27/19.
//  Copyright © 2019 Sergei Kolesin. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let baseUrl = "https://ofp.ddns.net/"
    
    class func postFeedback(entityName: String, topicUuid: String, qualityLevelGrade: Int, comment: String? = nil, completion: ((Data?, Error?)->())? = nil) {
        let urlString = baseUrl + "api/feedback"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        var parameters: [String: Any] = [
            "entityName": entityName,
            "topicUuid": topicUuid,
            "latitude": LocationManager.shared.coordinate.latitude,
            "longitude": LocationManager.shared.coordinate.latitude,
            "qualityLevelGrade": qualityLevelGrade
        ]
        if let comment = comment {
            parameters["comment"] = comment
        }
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        URLSession.shared.dataTask(with: request) { (data, urlResponce, error) in
            DispatchQueue.main.async {
                guard let completion = completion else {
                    return
                }
                if let error = error {
                    completion(nil, error)
                } else if let data = data {
                    completion(data, nil)
                }
            }
        }.resume()
    }
    
    class func getTopics(completion: (([Topic]?, Error?)->())?) {
        let urlString = baseUrl + "api/topic"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, urlResponce, error) in
            DispatchQueue.main.async {
                guard let completion = completion else {
                    return
                }
                if let error = error {
                    completion(nil, error)
                } else if let data = data {
                    let topics = try! JSONDecoder().decode([Topic].self, from: data)
                    completion(topics, nil)
                }
            }
        }.resume()
    }
    
}
