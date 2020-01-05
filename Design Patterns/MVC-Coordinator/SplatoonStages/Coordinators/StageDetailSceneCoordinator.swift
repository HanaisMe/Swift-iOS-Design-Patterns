//
//  StageDetailSceneCoordinator.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2020/01/01.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

// MARK: - Coordinator Protocol
class StageDetailSceneCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    // MARK: - Reference to Parent Coordinator
    weak var delegate: StageDetailSceneDelegate?
    
    let navigationController: UINavigationController
    let stage: Stage
    
    required init(navigationController: UINavigationController,
                  selectedStage: Stage) {
        self.navigationController = navigationController
        self.stage = selectedStage
    }
    
    func start() {
        let stageDetailVC: StageDetailViewController = ViewControllers.initiate(from: .main)
        stageDetailVC.delegate = self
        stageDetailVC.stage = stage
        self.navigationController.pushViewController(stageDetailVC, animated: true)
    }
}

// MARK: - Stage Detail Scene Delegate
extension StageDetailSceneCoordinator: StageDetailSceneDelegate {
    
    func navigateToStagesScene() {
        self.delegate?.navigateToStagesScene()
    }
}
