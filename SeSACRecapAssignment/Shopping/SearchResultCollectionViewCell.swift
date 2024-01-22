//
//  SearchResultCollectionViewCell.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/21/24.
//

import UIKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    
  @IBOutlet var itemImageView: UIImageView!
  
  @IBOutlet var likeButton: UIButton!
  
  @IBOutlet var mallNameLabel: UILabel!
  
  @IBOutlet var titleLabel: UILabel!
  
  @IBOutlet var lpriceLabel: UILabel!

  override class func awakeFromNib() {
    super.awakeFromNib()

  }



  
}
