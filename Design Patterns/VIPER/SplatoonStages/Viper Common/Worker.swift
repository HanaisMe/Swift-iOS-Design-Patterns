//
//  Worker.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2020/01/01.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import Foundation

// MARK: - Worker (Datasource)
class Worker {
    
    static let shared = Worker()
    private init() {}
    
    func fetchStages(success: @escaping ([Stage]) -> Void,
                     failure: @escaping (String) -> Void) {
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
    
    func fetchData(from url: URL,
                   success: @escaping (Data) -> Void,
                   failure: @escaping (String) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let theError = error {
                failure(theError.localizedDescription)
                return
            }
            guard let theData = data else {
                failure("empty data")
                return
            }
            success(theData)
        }.resume()
    }
}
