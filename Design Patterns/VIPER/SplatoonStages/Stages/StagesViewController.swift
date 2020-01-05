//
//  StagesViewController.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/30.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import UIKit

// MARK: - Stages View
class StagesViewController: UIViewController, ViperView {
    
    // MARK: - Viper Presenter Protocol
    typealias PresenterType = StagesPresenter
    var presenter: StagesPresenter?
 
    @IBOutlet var stagesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        stagesTableView.dataSource = self
        stagesTableView.delegate = self
        title = "Stages"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchStages()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.stagesTableView.reloadData()
        }
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

// MARK: - StageTableViewCell
class StageTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
}
