//
//  QualityLevel.swift
//  MakeathonDemo
//
//  Created by Sergei Kolesin on 2/27/19.
//  Copyright © 2019 Sergei Kolesin. All rights reserved.
//

import Foundation

class QualityLevel: Codable {
    var qualityLevelDescription: String
    var qualityLevelGrade: Int
    var qualityLevelName: String
    
    init(qualityLevelDescription: String, qualityLevelGrade: Int, qualityLevelName: String) {
        self.qualityLevelDescription = qualityLevelDescription
        self.qualityLevelGrade = qualityLevelGrade
        self.qualityLevelName = qualityLevelName
    }
}
