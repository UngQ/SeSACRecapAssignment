//
//  SettingTableViewCell.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/22/24.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .darkGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
