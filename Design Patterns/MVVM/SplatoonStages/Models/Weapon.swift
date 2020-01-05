//
//  Weapon.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/30.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import Foundation

struct LocalizedStrings: Codable {
    let english : String
    let japanese: String
    let french  : String
    
    enum CodingKeys: String, CodingKey {
        case english  = "en_US"
        case japanese = "ja_JP"
        case french   = "fr_FR"
    }
}

struct Description: Codable {
    let key : String
    let name: LocalizedStrings
    
    enum Description: String, CodingKey {
        case key  = "key"
        case name = "name"
    }
}

struct Weapon: Codable {
    let key    : String
    let name   : LocalizedStrings
    let sub    : Description
    let special: Description
    
    enum Weapon: String, CodingKey {
        case key     = "key"
        case name    = "name"
        case sub     = "sub"
        case special = "special"
    }
}
