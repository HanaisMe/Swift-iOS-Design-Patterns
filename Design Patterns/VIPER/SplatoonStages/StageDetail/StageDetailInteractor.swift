//
//  StageDetailInteractor.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/31.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import Foundation

// MARK: - Stage Detail Interactor
class StageDetailInteractor: ViperInteractor {
    weak var presenter: StageDetailPresenter?
    
    func fetchData(from url: URL,
                   success: @escaping (Data) -> Void,
                   failure: @escaping (String) -> Void) {
        Worker.shared.fetchData(from: url, success: { data in
            success(data)
        }, failure: { errorMessage in
            failure(errorMessage)
        })
    }
}
