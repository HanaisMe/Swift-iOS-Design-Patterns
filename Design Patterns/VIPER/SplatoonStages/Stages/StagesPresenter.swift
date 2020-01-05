//
//  StagesPresenter.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/31.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import Foundation

// MARK: - Stages Presenter
class StagesPresenter: NSObject, ViperPresenter {
    
    // MARK: - Viper Presenter Protocol
    typealias InteractorType = StagesInteractor
    typealias RouterType = StagesRouter
   
    weak var view: StagesViewController?
    var interactor: StagesInteractor?
    var router: StagesRouter?
    
    // MARK: - Data Transform
    var stages = [Stage]()
    
    func fetchStages() {
        self.interactor?.fetchStages(success: { [weak self] stages in
            self?.stages = stages
            self?.view?.reloadTableView()
        }, failure: { errorMessage in
            print(errorMessage)
        })
    }
    
    func getStages() -> [Stage] {
        return self.stages
    }
    
    // MARK: - Intercept UI action
    func selectStage(index: Int) {
        self.router?.routeToStageDetail(with: stages[index])
    }
}
