//
//  SearchTableViewCell.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/21/24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

  @IBOutlet var currentSearchTextLabel: UILabel!

    @IBOutlet var magnifyingglassButton: UIButton!
    @IBOutlet var xmarkButton: UIButton!

  override func awakeFromNib() {
    super.awakeFromNib()
    
      backgroundColor = .sesacBackground
    currentSearchTextLabel.textColor = .sesacText
    currentSearchTextLabel.font = .systemFont(ofSize: 13)

      magnifyingglassButton.setTitle("", for: .normal)
      magnifyingglassButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)

      xmarkButton.setTitle("", for: .normal)
      xmarkButton.setImage(UIImage(systemName: "xmark"), for: .normal)
      xmarkButton.contentMode = .center
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        selectionStyle = .blue
    }

    

}
