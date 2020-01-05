//
//  APIManager.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/30.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import Foundation

class ApiManager {
    
    // MARK: - API Manager Singleton
    static let shared = ApiManager()
    private init() {}
    
    func fetchWeapons(success: @escaping ([Weapon]) -> Void,
                      failure: @escaping (String) -> Void) {
        let urlString = StatInkAPI.getUrlString(type: .weaponList)
        guard let url = URL(string: urlString) else {
            failure("url parsing error")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let theError = error {
                failure(theError.localizedDescription)
                return
            }
            guard let theData = data else {
                failure("empty data error")
                return
            }
            do {
                let weapons = try JSONDecoder().decode([Weapon].self, from: theData)
                success(weapons)
            } catch let error {
                failure(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchStages(//by battleStyle: Spla2Yuu26API.BattleStyle,
                     success: @escaping ([Stage]) -> Void,
                     failure: @escaping (String) -> Void) {
//        let urlString = Spla2Yuu26API.getUrlString(type: battleStyle)
        guard let url = Bundle.main.url(forResource: "Stages", withExtension: "json") else {
            failure("json file detection error")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(Stages.self, from: data)
            success(response.result)
        } catch let error {
            failure(error.localizedDescription)
        }
    }
}
