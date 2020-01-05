//
//  TableViewCells.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/30.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import UIKit

class StageTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
}

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
