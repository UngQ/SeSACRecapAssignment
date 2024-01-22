//
//  PersonalInformationTableViewCell.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/22/24.
//

import UIKit

class PersonalInformationTableViewCell: UITableViewCell {

    @IBOutlet var profileImageButton: UIButton!
    @IBOutlet var nicknameLabel: UILabel!
    
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var likeSubLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .darkGray

        DispatchQueue.main.async {
            let radius = self.profileImageButton.frame.width / 2
            self.profileImageButton.layer.cornerRadius = radius
        }

        profileImageButton.setImage(UIImage(imageLiteralResourceName: "profile\(UserDefaults.standard.integer(forKey: "ImageNumber"))"), for: .normal)
        profileImageButton.setTitle("", for: .normal)

        profileImageButton.layer.masksToBounds = true
        profileImageButton.layer.borderColor = UIColor.sesacPoint.cgColor
        profileImageButton.layer.borderWidth = 3

        nicknameLabel.text = UserDefaults.standard.string(forKey: "Nickname")
        nicknameLabel.textColor = .sesacText
        nicknameLabel.font = .boldSystemFont(ofSize: 20)

        var count = UserDefaults.standard.dictionary(forKey: "Count") ?? [:]
        likeLabel.text = "\(count.count)개의 상품"
        likeLabel.font = .boldSystemFont(ofSize: 13)
        likeLabel.textColor = .sesacPoint
        likeSubLabel.text = "을 좋아하고 있어요!"
        likeSubLabel.font = .boldSystemFont(ofSize: 13)
        likeSubLabel.textColor = .sesacText

    }



    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
    }
    
}
