//
//  StagesRouter.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/31.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import Foundation

// MARK: - Stages Router
class StagesRouter: ViperRouter {
    weak var view: StagesViewController?
    
    func routeToStageDetail(with stage: Stage) {
        let stageDetailVC = Builder.buildStageDetailModule(stage: stage)
        self.view?.navigationController?.pushViewController(stageDetailVC, animated: true)
    }
}
