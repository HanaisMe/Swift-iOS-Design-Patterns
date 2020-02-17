//
//  StageDetailPresenter.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/31.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import Foundation

// MARK: - Stage Detail Presenter
class StageDetailPresenter {
    
    // MARK: - Delegate
    weak private var delegate : StageDetailDelegate?
    init(delegate: StageDetailDelegate, selectedStage: Stage) {
        self.delegate = delegate
        self.selectedStage = selectedStage
    }
    
    // MARK: - View Binding
    private(set) var state: AppState = .loading {
        didSet {
            delegate?.updateAppState(state)
        }
    }
    private(set) var downloadedData: Data? = nil {
        didSet {
            delegate?.updateDownloadedData()
        }
    }
    private var selectedStage: Stage?
    
    // MARK: - Interaction with Data Source
    private let service = ApiManager.shared
    
    func fetchData() {
        guard let stage = self.selectedStage else { return }
        self.state = .loading
        self.downloadedData = nil
        URLSession.shared.dataTask(with: stage.imageURL) { data, response, error in
            if let theError = error {
                self.state = .error(message: theError.localizedDescription)
                return
            }
            self.state = .active
            self.downloadedData = data
        }.resume()
    }
    
    func getSelectedStage() -> Stage? {
        return self.selectedStage
    }
    
    func getDownloadedData() -> Data? {
        return self.downloadedData
    }
}
