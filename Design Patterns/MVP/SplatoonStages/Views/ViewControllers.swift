//
//  ViewControllers.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/30.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
}

class ViewControllers {
    static func initiate<T>(from storyboard: Storyboard) -> T {
        let storyboard = UIStoryboard.init(name: storyboard.rawValue, bundle: nil)
        let className = String(describing: T.self)
        let theVC = storyboard.instantiateViewController(withIdentifier: className) as! T
        return theVC
    }
}

// MARK: - Loading View
class CustomViewController: UIViewController {
    
    private var loadingView = UIView()
    
    func setupLoadingView() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 80),
            containerView.widthAnchor.constraint(equalToConstant: 80),
        ])
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = Constants.red

        let activityView = UIActivityIndicatorView(style: .large)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(activityView)
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityView.heightAnchor.constraint(equalToConstant: 80),
            activityView.widthAnchor.constraint(equalToConstant: 80),
        ])
        activityView.startAnimating()
        
        self.loadingView = containerView
        self.loadingView.isHidden = true
    }
    
    func setLoadingView(show: Bool) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = !show
        }
    }
}
