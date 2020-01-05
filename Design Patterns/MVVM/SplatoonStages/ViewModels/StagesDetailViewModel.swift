//
//  StagesDetailViewModel.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/31.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import Foundation

// MARK: - Stage Detail Data Binding Protocol
protocol StageDetailDataBinding: AnyObject {
    var updateAppState: ((_ state: AppState) -> ())? { get set }
    var updateDownloadedData: (() -> ())? { get set }
}

// MARK: - Stages View Model
class StageDetailViewModel: StageDetailDataBinding {
    private(set) var state: AppState = .loading {
        didSet {
            self.updateAppState?(state)
        }
    }
    private(set) var downloadedData: Data? = nil {
        didSet {
            self.updateDownloadedData?()
        }
    }
    private var selectedStage: Stage?
    
    init(stage: Stage) {
        self.selectedStage = stage
    }
    
    // MARK: - Data Binding
    var updateAppState: ((_ state: AppState) -> ())?
    var updateDownloadedData: (() -> ())?
    
    // MARK: - Command
    func fetchData() {
        guard let stage = self.selectedStage else { return }
        self.state = .loading
        self.downloadedData = nil
        URLSession.shared.dataTask(with: stage.image_url) { data, response, error in
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
