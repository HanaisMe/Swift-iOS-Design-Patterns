//
//  StagesViewController.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/30.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import UIKit

class StagesViewController: UIViewController {
    
    @IBOutlet var stagesTableView: UITableView!
    var stages = [Stage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        stagesTableView.dataSource = self
        stagesTableView.delegate = self
        title = "Stages"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchStages()
    }
    
    private func fetchStages() {
        ApiManager.shared.fetchStages(success: { [weak self] stages in
            self?.stages = stages
            self?.stagesTableView.reloadData()
        }, failure: { errorMessage in
            print(errorMessage)
        })
    }
}

extension StagesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stages.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.stageCellId, for: indexPath) as! StageTableViewCell
        cell.nameLabel.text = stages[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stageDetailVC: StageDetailViewController = ViewControllers.initiate(from: .main)
        stageDetailVC.stage = stages[indexPath.row]
        self.navigationController?.pushViewController(stageDetailVC, animated: true)
    }
}
