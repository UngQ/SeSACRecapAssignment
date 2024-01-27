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
		titleLabel.font = .boldSystemFont(ofSize: 14)
		titleLabel.textColor = .sesacText

    }

}
