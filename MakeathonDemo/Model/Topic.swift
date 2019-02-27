//
//  Topic.swift
//  MakeathonDemo
//
//  Created by Sergei Kolesin on 2/27/19.
//  Copyright © 2019 Sergei Kolesin. All rights reserved.
//

import Foundation

class Topic: Codable {
    var description: String
    var name: String
    var qualityLevels: [QualityLevel]
    var uuid: String
    
    init(description: String, name: String, qualityLevels: [QualityLevel], uuid: String) {
        self.description = description
        self.name = name
        self.qualityLevels = qualityLevels
        self.uuid = uuid
    }
}
