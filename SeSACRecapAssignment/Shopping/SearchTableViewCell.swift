//
//  SearchTableViewCell.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/21/24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

  @IBOutlet var magnifyingglassImageView: UIImageView!

  @IBOutlet var currentSearchTextLabel: UILabel!

  @IBOutlet var xmarkImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    backgroundColor = .clear
    currentSearchTextLabel.textColor = .sesacText
    currentSearchTextLabel.font = .systemFont(ofSize: 13)
    magnifyingglassImageView.image = UIImage(systemName: "magnifyingglass")
    magnifyingglassImageView.contentMode = .center

    xmarkImageView.image = UIImage(systemName: "xmark")
    xmarkImageView.contentMode = .center
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
