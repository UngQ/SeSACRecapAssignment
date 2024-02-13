//
//  CodeProfileSettingViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/10/24.
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

class CodeProfileSettingViewController: BaseViewController {

	var pass: Bool = false
	let image = UserDefaults.standard.integer(forKey: "ImageNumber")

	let mainView = CodeProfileSettingView()


	override func loadView() {
		view = mainView
	}

	override func viewWillAppear(_ animated: Bool) {
		let image = UserDefaults.standard.integer(forKey: "ImageNumber")
		mainView.profileImageView.image = UIImage(imageLiteralResourceName: 		ProfileImage.allCases[image].rawValue)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureHierarchy() {

	}


	override func configureView() {

		mainView.inputTextField.delegate = self

		let profileImageViewGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageButtonClicked))

		mainView.profileImageView.addGestureRecognizer(profileImageViewGesture)
		mainView.profileImageView.isUserInteractionEnabled = true

		mainView.okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)

	}

	@objc func profileImageButtonClicked() {
		navigationController?.pushViewController(CodeProfileImageSettingViewController(), animated: true)
	}

	@objc func okButtonClicked() {
		UserDefaults.standard.setValue(true, forKey: "UserState")

		let vc = CustomTabBarController()
		vc.modalTransitionStyle = .crossDissolve
		vc.modalPresentationStyle = .fullScreen
		present(vc, animated: true)
//		if pass {
//			UserDefaults.standard.setValue(mainView.inputTextField.text, forKey: "Nickname")
//			if UserDefaults.standard.bool(forKey: "UserState") == true {
//				navigationController?.popViewController(animated: true)
//			} else {
//				UserDefaults.standard.setValue(true, forKey: "UserState")
//
//				let vc = CustomTabBarController()
//				vc.modalTransitionStyle = .crossDissolve
//				vc.modalPresentationStyle = .fullScreen
//				present(vc, animated: true)
//			}
//		} else {
//			print("닉네임 확인요망")
//		}
	}

	func filteringNickname2(text: String) throws -> String {
		print(#function)

		guard mainView.inputTextField.text!.count >= 2 &&
				mainView.inputTextField.text!.count < 10 else {
			throw ValidationError.limitCharacter
		}
		guard !mainView.inputTextField.text!.contains("@") &&
				!mainView.inputTextField.text!.contains("#") &&
				!mainView.inputTextField.text!.contains("$") &&
				!mainView.inputTextField.text!.contains("%") == true else {

			throw ValidationError.restrictSymbol
		}
		guard mainView.inputTextField.text!.rangeOfCharacter(from: .decimalDigits) == nil else {

			throw ValidationError.restrictInt
		}


		return "사용할 수 있는 닉네임이에요"
	}

}


extension CodeProfileSettingViewController: UITextFieldDelegate {

	func textFieldDidChangeSelection(_ textField: UITextField) {

		guard let text = mainView.alertLabel.text else { return }
		do {
			pass = true
			mainView.alertLabel.text = try filteringNickname2(text: text)
		} catch {
			pass = false
			switch error {
			case ValidationError.limitCharacter: mainView.alertLabel.text = ValidationError.limitCharacter.caution
			case ValidationError.restrictSymbol: mainView.alertLabel.text = ValidationError.restrictSymbol.caution
			case ValidationError.restrictInt: mainView.alertLabel.text = ValidationError.restrictInt.caution
			default: mainView.alertLabel.text = ValidationError.unknown.caution
			}
		}
	}

}
