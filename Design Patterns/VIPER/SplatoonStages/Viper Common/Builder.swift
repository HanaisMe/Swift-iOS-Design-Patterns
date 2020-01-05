//
//  Builder.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2020/01/01.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
}

// MARK: - Module Builder
class Builder {
    
    // MARK: - Common initializer
    static func initiate<T>(from storyboard: Storyboard) -> T {
        let storyboard = UIStoryboard.init(name: storyboard.rawValue, bundle: nil)
        let className = String(describing: T.self)
        let theVC = storyboard.instantiateViewController(withIdentifier: className) as! T
        return theVC
    }
    
    // MARK: - Stages Module
    class func buildStagesModule() -> UIViewController {
        // init
        let view: StagesViewController = self.initiate(from: .main)
        let interactor = StagesInteractor()
        let presenter = StagesPresenter()
        let router = StagesRouter()
        
        // Link Viper Components
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.view = view
        return view
    }
    
    // MARK: - Stages Module
    class func buildStageDetailModule(stage: Stage) -> UIViewController {
        // init
        let view: StageDetailViewController = self.initiate(from: .main)
        let interactor = StageDetailInteractor()
        let presenter = StageDetailPresenter(stage: stage)
        let router = StageDetailRouter()
        
        // Link Viper Components
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.view = view
        return view
    }
}
