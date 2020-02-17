//
//  Stage.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/30.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import Foundation

enum StageInfo: String, CaseIterable {
    case id      = "ID"
    case name    = "Name"
    case statink = "Statink"
    case image   = "Map Image"
}

struct Stage: Codable {
    let id       : Int
    let name     : String
    let imageURL : URL
    let statink  : String
    
    enum CodingKeys: String, CodingKey {
        case id        = "id"
        case name      = "name"
        case imageURL  = "image_url"
        case statink   = "statink"
    }
}

struct Stages: Codable {
    let result: [Stage]
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
    }
}
