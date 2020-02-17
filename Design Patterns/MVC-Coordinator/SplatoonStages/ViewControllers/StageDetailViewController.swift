//
//  StageDetailViewController.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/30.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import UIKit

// MARK: - Screen Transition Delegate
protocol StageDetailSceneDelegate: AnyObject {
    func navigateToStagesScene()
}

class StageDetailViewController: UIViewController {
    weak var delegate: StageDetailSceneDelegate?
    
    @IBOutlet var stageDetailTableView: UITableView!
    
    var stage: Stage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stageDetailTableView.dataSource = self
        stageDetailTableView.delegate = self
        title = "Stage Detail"
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backToStagesScene))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backToStagesScene() {
        delegate?.navigateToStagesScene()
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
        guard let selectedStage = self.stage else { return cell }
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
            cell.detailImageView.fromImageURL(selectedStage.imageURL)
        default:
            break
        }
        return cell
    }
}

// MARK: - StageDetailTableViewCell
class StageDetailTableViewCell: UITableViewCell {
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var detailImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        headerLabel.text = nil
        detailLabel.text = nil
        detailImageView.image = nil
    }
}
