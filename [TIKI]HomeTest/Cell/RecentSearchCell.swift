//
//  RecentSearchCell.swift
//  [TIKI]HomeTest
//
//  Created by ThanhHai on 9/25/18.
//  Copyright © 2018 ThanhHai. All rights reserved.
//

import UIKit

class RecentSearchCell: UICollectionViewCell {

    @IBOutlet weak var lblKeyword: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
    }

}
