//
//  ProfileImageSettingViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungq on 1/19/24.
//

import UIKit

class ProfileImageSettingViewController: UIViewController {

  @IBOutlet weak var selectedProfileImage: UIImageView!

  @IBOutlet var profileImages: [UIImageView]!
  @IBOutlet var profileButtons: [UIButton]!
    var selected: Int = UserDefaults.standard.integer(forKey: "ImageNumber")

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "프로필 설정"
      let item = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
      navigationItem.rightBarButtonItem = item
    view.backgroundColor = .sesacBackground

    selectedProfileImage.image = UIImage(imageLiteralResourceName: "profile\(UserDefaults.standard.integer(forKey: "ImageNumber"))")
    selectedProfileImage.layer.masksToBounds = true
    selectedProfileImage.layer.cornerRadius = selectedProfileImage.frame.width / 2
    selectedProfileImage.layer.borderColor = UIColor.sesacPoint.cgColor
    selectedProfileImage.layer.borderWidth = 6


    for i in 0...ProfileImage.allCases.count - 1 {
      if i == UserDefaults.standard.integer(forKey: "ImageNumber") - 1 {
        profileImages[i].layer.borderColor = UIColor.sesacPoint.cgColor
        profileImages[i].layer.borderWidth = 4
      }

      profileButtons[i].tag = i
      profileImages[i].tag = i
      profileImages[i].image = UIImage(imageLiteralResourceName: "profile\(i + 1)")
      profileImages[i].layer.masksToBounds = true
      profileImages[i].layer.cornerRadius = profileImages[i].frame.width / 2

    }

    for i in 0...ProfileImage.allCases.count - 1 {
      profileButtons[i].setTitle("", for: .normal)
      profileButtons[i].layer.masksToBounds = true
      profileButtons[i].layer.cornerRadius = profileImages[i].layer.cornerRadius
    }

  }

    @objc func saveButtonClicked() {
        UserDefaults.standard.setValue(selected, forKey: "ImageNumber")
        navigationController?.popViewController(animated: true)
    }

  @IBAction func imageClicked(_ sender: UIButton) {

    for i in 0...ProfileImage.allCases.count - 1 {
      if sender.tag == i {
        profileImages[i].layer.borderColor = UIColor.sesacPoint.cgColor
        profileImages[i].layer.borderWidth = 4
        selectedProfileImage.image = UIImage(imageLiteralResourceName: "profile\(i + 1)")
        selected = i + 1


      } else {
        profileImages[i].layer.borderColor = UIColor.clear.cgColor
        profileImages[i].layer.borderWidth = 0
      }
    }
  }
}
