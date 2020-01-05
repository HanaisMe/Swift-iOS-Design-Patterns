//
//  StagesInteractor.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/31.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import Foundation

// MARK: - Stages Interactor
class StagesInteractor: NSObject, ViperInteractor {
    weak var presenter: StagesPresenter?
    
    func fetchStages(success: @escaping ([Stage]) -> Void,
                     failure: @escaping (String) -> Void) {
        Worker.shared.fetchStages(success: { stages in
            success(stages)
        }, failure: { errorMessage in
            failure(errorMessage)
        })
    }
}
