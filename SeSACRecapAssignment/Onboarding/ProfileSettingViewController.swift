//
//  ProfileSettingViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungq on 1/18/24.
//

import UIKit

enum ValidationError: Error {
	case limitCharacter
	case restrictSymbol
	case restrictInt
	case unknown

	var caution: String {
		switch self {
		case .limitCharacter:
			"2글자 이상 10글자 미만으로 설정해주세요"
		case .restrictSymbol:
			"닉네임에 @, #, $, % 는 포함할 수 없어요"
		case .restrictInt:
			"닉네임에 숫자는 포함할 수 없어요"
		case .unknown:
			"알 수 없는 오류"
		}
	}

}

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
	let image = UserDefaults.standard.integer(forKey: "ImageNumber")

    override func viewDidLoad() {
        super.viewDidLoad()
		print("viewDidLoad")
		configureView()
        
    }


    override func viewWillAppear(_ animated: Bool) {
		print("viewWillAppear")
		let image = UserDefaults.standard.integer(forKey: "ImageNumber")
		profileImageView.image = UIImage(imageLiteralResourceName: 		ProfileImage.allCases[image].rawValue)
        
    }


    @objc func profileImageButtonClicked() {
//        let vc = storyboard?.instantiateViewController(withIdentifier: ProfileImageSettingViewController.identifier) as! ProfileImageSettingViewController
        navigationController?.pushViewController(CodeProfileImageSettingViewController(), animated: true)
    }

    @objc func completeButtonClicked() {
        if pass {
            UserDefaults.standard.setValue(userInputTextField.text, forKey: "Nickname")
            if UserDefaults.standard.bool(forKey: "UserState") == true {
                navigationController?.popViewController(animated: true)
            } else {
                UserDefaults.standard.setValue(true, forKey: "UserState")
				notificationSet()

				let vc = CustomTabBarController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
            }
        } else {
            print("닉네임 확인요망")
        }
    }

	func filteringNickname2(text: String) throws -> String {
		print(#function)

		guard userInputTextField.text!.count >= 2 &&
				userInputTextField.text!.count < 10 else {
			throw ValidationError.limitCharacter
		}
		guard !userInputTextField.text!.contains("@") &&
				!userInputTextField.text!.contains("#") &&
				!userInputTextField.text!.contains("$") &&
				!userInputTextField.text!.contains("%") == true else {

			throw ValidationError.restrictSymbol
		}
		guard userInputTextField.text!.rangeOfCharacter(from: .decimalDigits) == nil else {

			throw ValidationError.restrictInt
		}


		return "사용할 수 있는 닉네임이에요"
	}

//    func filteringNickname() -> String {
//        print(#function)
//
//        guard userInputTextField.text!.count >= 2 &&
//                userInputTextField.text!.count < 10 else {
//            pass = false
//            return "2글자 이상 10글자 미만으로 설정해주세요"
//        }
//        guard !userInputTextField.text!.contains("@") &&
//                !userInputTextField.text!.contains("#") &&
//                !userInputTextField.text!.contains("$") &&
//                !userInputTextField.text!.contains("%") == true else {
//            pass = false
//            return "닉네임에 @, #, $, % 는 포함할 수 없어요"
//        }
//        guard userInputTextField.text!.rangeOfCharacter(from: .decimalDigits) == nil else {
//            pass = false
//            return "닉네임에 숫자는 포함할 수 없어요"
//        }
//
//        pass = true
//
//        return "사용할 수 있는 닉네임이에요"
//    }
}

extension ProfileSettingViewController {
	func configureView() {
		view.backgroundColor = .sesacBackground
		navigationItem.title = "프로필 설정"
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.sesacText.cgColor]

		let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
		self.navigationItem.backBarButtonItem = backBarButton

		imageBackView.backgroundColor = .clear

		profileImageView.layer.masksToBounds = true
		profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
		profileImageView.layer.borderColor = UIColor.sesacPoint.cgColor
		profileImageView.layer.borderWidth = 6


		profileImageButton.setTitle("", for: .normal)
		profileImageButton.layer.masksToBounds = true
		profileImageButton.layer.cornerRadius = profileImageView.frame.width / 2

		cameraImageView.image =  .camera

		stackView.backgroundColor = .clear

		userInputTextField.text = UserDefaults.standard.string(forKey: "Nickname") ?? ""
		userInputTextField.delegate = self
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
	
	func notificationSet() {
		
		let content = UNMutableNotificationContent()
		content.title = "쇼핑 안하세요?"
		content.body = "하루에 한번은 하셔야죠!!"
		content.badge = 2
		
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
		
		var component = DateComponents()
		component.second = 30
		let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: true)
		
		let request = UNNotificationRequest(identifier: "test", content: content, trigger: calendarTrigger)
		
		UNUserNotificationCenter.current().add(request)
	}
}


extension ProfileSettingViewController: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {

		guard let text = resultLabel.text else { return }
		do {
			pass = true
			resultLabel.text = try filteringNickname2(text: text)
		} catch {
			pass = false
			switch error {
			case ValidationError.limitCharacter: resultLabel.text = ValidationError.limitCharacter.caution
			case ValidationError.restrictSymbol: resultLabel.text = ValidationError.restrictSymbol.caution
			case ValidationError.restrictInt: resultLabel.text = ValidationError.restrictInt.caution
			default: resultLabel.text = ValidationError.unknown.caution
			}
		}
    }

}
