//
//  OnboardingViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungq on 1/18/24.
//

import UIKit


class OnboardingViewController: UIViewController {

	@IBOutlet var titleImageView: UIImageView!
	@IBOutlet var mainImageView: UIImageView!
	@IBOutlet var startButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()

		configureView()

	}
	
	override func viewWillAppear(_ animated: Bool) {

		UserDefaults.standard.setValue(Int.random(in: 0...ProfileImage.allCases.count-1), forKey: UserDefaultsKey.imageNumber.rawValue)
		UserDefaults.standard.setValue("", forKey: UserDefaultsKey.nickname.rawValue)
		UserDefaults.standard.setValue([], forKey: UserDefaultsKey.searchHistory.rawValue)
		UserDefaults.standard.setValue([], forKey: UserDefaultsKey.wish.rawValue)

		SearchViewController.searchItem = ""
		SearchViewController.wishList = []

	}

	@objc func startButtonClicked() {
		let vc =  storyboard?.instantiateViewController(identifier: ProfileSettingViewController.identifier) as! ProfileSettingViewController
		navigationController?.pushViewController(vc, animated: true)
	}

	func configureView() {

		let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
		self.navigationItem.backBarButtonItem = backBarButton
		self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

		view.backgroundColor = .sesacBackground

		titleImageView.image = .sesacShopping
		titleImageView.contentMode = .center
		mainImageView.image = .onboarding

		startButton.setTitle("시작하기", for: .normal)
		startButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
		startButton.backgroundColor = .sesacPoint
		startButton.layer.cornerRadius = 5
		startButton.layer.masksToBounds = true

		startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
	}


}


