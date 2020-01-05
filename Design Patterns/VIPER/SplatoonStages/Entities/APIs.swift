//
//  APIs.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/30.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import Foundation

// MARK: - https://spla2.yuu26.com/
// `あくまで個人用に作成した非公式なものですが、ご自由にお使いください。`
enum Spla2Yuu26API {
    static let domain = "https://spla2.yuu26.com/"
    
    enum BattleStyle: String {
        case regular = "regular"
        case gachi   = "gachi"
        case league  = "league"
    }
    
    static func getUrlString(type: BattleStyle) -> String {
        return domain + type.rawValue
    }
}


