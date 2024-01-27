//
//  ResultCollectionViewCell.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/26/24.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {


	@IBOutlet var itemImageView: UIImageView!

	@IBOutlet var likeButton: UIButton!

	@IBOutlet var mallNameLabel: UILabel!

	@IBOutlet var titleLabel: UILabel!

	@IBOutlet var lpriceLabel: UILabel!

	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
