//
//  Coordinator.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2020/01/01.
//  Copyright © 2020 Jeongsik Lee. All rights reserved.
//

import UIKit

// MARK: - Coordinator Protocol
protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    
//    init(navigationController: UINavigationController)
    
    func start()
}
