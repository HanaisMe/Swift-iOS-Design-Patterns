//
//  StagesPresenter.swift
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

// MARK: - Stages Presenter
class StagesPresenter {
    
    // MARK: - Delegate
    weak private var delegate : StagesDelegate?
    init(delegate: StagesDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - View Binding
    private(set) var state: AppState = .loading {
        didSet {
            delegate?.updateAppState(state)
        }
    }
    private(set) var stages: [Stage] = [Stage]() {
        didSet {
            delegate?.updateStages()
        }
    }
    private(set) var selectedStage: Stage? = nil {
        didSet {
            delegate?.updateSelectedStage(selectedStage)
        }
    }
    
    // MARK: - Interaction with Data Source
    private let service = ApiManager.shared
    
    func fetchStages() {
        self.state = .loading
        service.fetchStages(success: { stages in
            self.state = .active
            self.stages = stages
        }, failure: { errorMessage in
            self.state = .error(message: errorMessage)
        })
    }
    
    func getStages() -> [Stage] {
        return self.stages
    }
    
    func selectStage(index: Int) {
        self.selectedStage = stages[index]
    }
}
