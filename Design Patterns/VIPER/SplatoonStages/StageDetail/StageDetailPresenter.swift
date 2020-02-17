//
//  StageDetailPresenter.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/31.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import Foundation

// MARK: - Stage Detail Presenter
class StageDetailPresenter: NSObject, ViperPresenter {
    
    // MARK: - Viper Presenter Protocol
    typealias InteractorType = StageDetailInteractor
    typealias RouterType = StageDetailRouter
    
    weak var view: StageDetailViewController?
    var interactor: StageDetailInteractor?
    var router: StageDetailRouter?
    
    // MARK: - Intercept UI action from previous screen
    let selectedStage: Stage
    
    required init(stage: Stage) {
        self.selectedStage = stage
    }
    
    // MARK: - Data Transform
    var downloadedData: Data?
    
    func fetchData() {
        self.interactor?.fetchData(from: selectedStage.imageURL, success: { [weak self] data in
            self?.downloadedData = data
            self?.view?.reloadTableView()
        }, failure: { errorMessage in
            print(errorMessage)
        })
    }
    
    func getSelectedStage() -> Stage? {
        return self.selectedStage
    }
    
    func getDownloadedData() -> Data? {
        return self.downloadedData
    }
}
