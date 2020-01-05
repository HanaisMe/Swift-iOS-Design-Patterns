//
//  StagesViewModel.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/31.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import Foundation

// MARK: - App State Enum
enum AppState: Equatable {
    case active
    case loading
    case error(message: String)
}

// MARK: - Stages Data Binding Protocol
protocol StagesDataBinding: AnyObject {
    var updateAppState: ((_ state: AppState) -> ())? { get set }
    var updateStages: (() -> ())? { get set }
    var updateSelectedStage: ((_ stage: Stage?) -> ())? { get set }
}

// MARK: - Stages View Model
class StagesViewModel: StagesDataBinding {
    private(set) var state: AppState = .loading {
        didSet {
            self.updateAppState?(state)
        }
    }
    private(set) var stages: [Stage] = [Stage]() {
        didSet {
            self.updateStages?()
        }
    }
    private(set) var selectedStage: Stage? = nil {
        didSet {
            self.updateSelectedStage?(selectedStage)
        }
    }
    
    // MARK: - Data Binding
    var updateAppState: ((_ state: AppState) -> ())?
    var updateStages: (() -> ())?
    var updateSelectedStage: ((_ stage: Stage?) -> ())?
    
    // MARK: - Command
    func fetchStages() {
        self.state = .loading
        ApiManager.shared.fetchStages(success: { stages in
            self.state = .active
            self.stages = stages
        }, failure: { errorMessage in
            self.state = .error(message: errorMessage)
        })
    }
    
    func selectStage(index: Int) {
        self.selectedStage = self.stages[index]
    }
}
