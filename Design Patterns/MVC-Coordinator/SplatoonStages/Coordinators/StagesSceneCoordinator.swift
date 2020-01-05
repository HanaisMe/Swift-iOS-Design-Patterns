//
//  StagesSceneCoordinator.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2020/01/01.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

// MARK: - Coordinator Protocol
class StagesSceneCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let stagesVC: StagesViewController = ViewControllers.initiate(from: .main)
        stagesVC.delegate = self
        navigationController.viewControllers = [stagesVC]
    }
}

// MARK: - Stages Scene Delegate
extension StagesSceneCoordinator: StagesSceneDelegate {
    
    func navigateToStageDetailScene(with selectedStage: Stage) {
        let stageDetailSceneCoordinator = StageDetailSceneCoordinator(navigationController: navigationController,
                                                                 selectedStage: selectedStage)
        stageDetailSceneCoordinator.delegate = self
        childCoordinators.append(stageDetailSceneCoordinator)
        stageDetailSceneCoordinator.start()
    }
}

// MARK: - Stage Detail Scene Delegate
extension StagesSceneCoordinator: StageDetailSceneDelegate {
    
    func navigateToStagesScene() {
        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeLast()
    }
}


