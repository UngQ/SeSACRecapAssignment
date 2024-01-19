//
//  ProfileSettingViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungq on 1/18/24.
//

import UIKit

class ProfileSettingViewController: UIViewController {

    @IBOutlet var profileImageButton: UIButton!
    @IBOutlet var imageBackView: UIView!
    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet var stackView: UIView!
    
    @IBOutlet var userInputTextField: UITextField!
    @IBOutlet var lineView: UIView!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var completeButton: UIButton!
    
    var pass: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "프로필 설정"
 
        
        userInputTextField.delegate = self

        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
        
        
        
        view.backgroundColor = .black
        
        
        imageBackView.backgroundColor = .clear
        
        profileImageView.image = UIImage(imageLiteralResourceName: "profile\(Int.random(in: 1...9))")
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.borderColor = UIColor.sesacPoint.cgColor
        profileImageView.layer.borderWidth = 6
        
        profileImageButton.setTitle("", for: .normal)
        profileImageButton.layer.masksToBounds = true
        profileImageButton.layer.cornerRadius = profileImageView.frame.width / 2

        
        cameraImageView.image =  .camera
        
        stackView.backgroundColor = .clear
        userInputTextField.font = .systemFont(ofSize: 16)
        userInputTextField.textColor = .sesacText
        userInputTextField.backgroundColor = .clear
        //몰랐던 것1. placeholder 텍스트 컬러 변경
        userInputTextField.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요 :)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray.cgColor])
        
        
        lineView.backgroundColor = .white
        resultLabel.text = ""
        resultLabel.font = .systemFont(ofSize: 14)
        resultLabel.backgroundColor = .clear
        resultLabel.textColor = .sesacPoint
        
        completeButton.backgroundColor = .sesacPoint
        completeButton.setTitle("완료", for: .normal)
        completeButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        completeButton.layer.cornerRadius = 8
        completeButton.layer.masksToBounds = true
        
        profileImageButton.addTarget(self, action: #selector(profileImageButtonClicked), for: .touchUpInside)
        
        completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func profileImageButtonClicked() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileImageSettingViewController") as! ProfileImageSettingViewController
        navigationController?.pushViewController(vc, animated: true)
              }
    
    @objc func completeButtonClicked() {
        if pass {
            let sb = UIStoryboard(name: "WindowRoot", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "WindowRootViewController") as! WindowRootViewController
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else {
            print("닉네임 확인요망")
        }
    }
    
    func filteringNickname() -> String {
        print(#function)
        
        guard userInputTextField.text!.count >= 2 &&
                userInputTextField.text!.count < 10 else {
            pass = false
            return "2글자 이상 10글자 미만으로 설정해주세요"
        }
        guard !userInputTextField.text!.contains("@") &&
                !userInputTextField.text!.contains("#") &&
                !userInputTextField.text!.contains("$") &&
                !userInputTextField.text!.contains("%") == true else {
            pass = false
            return "닉네임에 @, #, $, % 는 포함할 수 없어요"
        }
        guard userInputTextField.text!.rangeOfCharacter(from: .decimalDigits) == nil else {
            pass = false
            return "닉네임에 숫자는 포함할 수 없어요"
        }
        
        pass = true
        
        return "사용할 수 있는 닉네임이에요"
    }
}


extension ProfileSettingViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        resultLabel.text = filteringNickname()
    }
    
}

extension UITextField {
    
    func setPlaceholderColor(_ placeholderColor: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ].compactMapValues { $0 }
        )
    }
    
}
