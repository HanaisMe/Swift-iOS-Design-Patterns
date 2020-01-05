//
//  StageDetailViewController.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/30.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import UIKit

class StageDetailViewController: CustomViewController, StageDetailDataBinding {
    
    var viewModel: StageDetailViewModel?
    var updateAppState: ((AppState) -> ())?
    var updateDownloadedData: (() -> ())?
    
    @IBOutlet var stageDetailTableView: UITableView!
    
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
        self.updateDownloadedData = { [weak self] in
            DispatchQueue.main.async {
                self?.stageDetailTableView.reloadData()
            }
        }
        // MARK: - Bind with View Model
        bindViewModel()
        
        stageDetailTableView.dataSource = self
        stageDetailTableView.delegate = self
        title = "Stage Detail"
        setupLoadingView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchData()
    }
    
    private func bindViewModel() {
        viewModel?.updateAppState = { [weak self] state in
            self?.updateAppState?(state)
        }
        viewModel?.updateDownloadedData = { [weak self] in
            self?.updateDownloadedData?()
        }
    }
}

extension StageDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StageInfo.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 3 ? 300 : 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.stageDetailCellId,
                                                 for: indexPath) as! StageDetailTableViewCell
        guard let selectedStage = viewModel?.getSelectedStage(),
            let downloadedData = viewModel?.getDownloadedData(),
            let downloadedImage = UIImage(data: downloadedData) else { return cell }
        switch indexPath.row {
        case 0:
            cell.headerLabel.text = StageInfo.id.rawValue
            cell.detailLabel.text = String(selectedStage.id)
            cell.detailImageView.image = nil
        case 1:
            cell.headerLabel.text = StageInfo.name.rawValue
            cell.detailLabel.text = selectedStage.name
            cell.detailImageView.image = nil
        case 2:
            cell.headerLabel.text = StageInfo.statink.rawValue
            cell.detailLabel.text = selectedStage.statink
            cell.detailImageView.image = nil
        case 3:
            cell.headerLabel.text = nil
            cell.detailLabel.text = nil
            cell.detailImageView.image = downloadedImage
        default:
            break
        }
        return cell
    }
}
