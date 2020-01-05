//
//  StagesViewController.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/30.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import UIKit

// MARK: - Stages Delegate
protocol StagesDelegate: AnyObject {
    func updateAppState(_ state: AppState) -> ()
    func updateStages() -> ()
    func updateSelectedStage(_ stage: Stage?) -> ()
}

// MARK: - Stages View
class StagesViewController: CustomViewController, StagesDelegate {
    var presenter: StagesPresenter?
 
    @IBOutlet var stagesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stagesTableView.dataSource = self
        stagesTableView.delegate = self
        title = "Stages"
        setupLoadingView()
        
        self.presenter = StagesPresenter(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchStages()
    }
    
    // MARK: - Delegate
    func updateAppState(_ state: AppState) {
        switch state {
        case .loading:
            self.setLoadingView(show: true)
        case .active:
            self.setLoadingView(show: false)
        case .error(let message):
            self.setLoadingView(show: false)
            print(message)
        }
    }
    
    func updateStages() {
        DispatchQueue.main.async {
            self.stagesTableView.reloadData()
        }
    }
    
    func updateSelectedStage(_ stage: Stage?) -> () {
        guard let theStage = stage else { return }
        let view: StageDetailViewController = ViewControllers.initiate(from: .main)
        view.presenter = StageDetailPresenter(delegate: view, selectedStage: theStage)
        self.navigationController?.pushViewController(view, animated: true)
    }
}

extension StagesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getStages().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.stageCellId, for: indexPath) as! StageTableViewCell
        cell.nameLabel.text = presenter?.getStages()[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectStage(index: indexPath.row)
    }
}
