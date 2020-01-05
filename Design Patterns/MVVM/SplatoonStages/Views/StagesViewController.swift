//
//  StagesViewController.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/30.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import UIKit

class StagesViewController: CustomViewController, StagesDataBinding {

    let viewModel = StagesViewModel()
    var updateAppState: ((AppState) -> ())?
    var updateStages: (() -> ())?
    var updateSelectedStage: ((Stage?) -> ())?
    
    @IBOutlet var stagesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Update View
        self.updateAppState = { [weak self] newState in
            switch newState {
            case .loading:
                self?.setLoadingView(show: true)
            case .active:
                self?.setLoadingView(show: false)
            case .error(let message):
                self?.setLoadingView(show: false)
                print(message)
            }
        }
        self.updateStages = { [weak self] in
            DispatchQueue.main.async {
                self?.stagesTableView.reloadData()
            }
        }
        self.updateSelectedStage = { [weak self] stage in
            guard let theStage = stage else { return }
            let view: StageDetailViewController = ViewControllers.initiate(from: .main)
            view.viewModel = StageDetailViewModel(stage: theStage)
            self?.navigationController?.pushViewController(view, animated: true)
        }
        // MARK: - Bind with View Model
        bindViewModel()
        
        stagesTableView.dataSource = self
        stagesTableView.delegate = self
        title = "Stages"
        setupLoadingView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchStages()
    }
    
    private func bindViewModel() {
        viewModel.updateAppState = { [weak self] state in
            self?.updateAppState?(state)
        }
        viewModel.updateStages = { [weak self] in
            self?.updateStages?()
        }
        viewModel.updateSelectedStage = { [weak self] stage in
            self?.updateSelectedStage?(stage)
        }
    }
}

extension StagesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stages.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.stageCellId, for: indexPath) as! StageTableViewCell
        cell.nameLabel.text = viewModel.stages[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectStage(index: indexPath.row)
    }
}
