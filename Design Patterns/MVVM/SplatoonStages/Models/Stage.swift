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
    let image_url: URL
    let statink  : String
    
    enum Stage: String, CodingKey {
        case id        = "id"
        case name      = "name"
        case image_url = "image_url"
        case statink   = "statink"
    }
}

struct Stages: Codable {
    let result: [Stage]
    
    enum Stages: String, CodingKey {
        case result = "result"
    }
}
