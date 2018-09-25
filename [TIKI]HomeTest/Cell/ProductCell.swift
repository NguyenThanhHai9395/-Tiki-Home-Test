//
//  ProductCell.swift
//  [TIKI]HomeTest
//
//  Created by ThanhHai on 9/24/18.
//  Copyright © 2018 ThanhHai. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {

    //MARK: - PROPERTIES
    
    @IBOutlet weak var imvProduct: UIImageView!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var vwTitle: UIView!
    @IBOutlet weak var lblProductWidthConstraint: NSLayoutConstraint!
    
    //MARK: - LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        vwTitle.layer.cornerRadius = 8
    }

}
