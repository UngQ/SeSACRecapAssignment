//
//  CodeOnboardingViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/10/24.
//

import UIKit
import SnapKit

class CodeOnboardingViewController: BaseViewController {

	let mainView = CodeOnboardingView()


	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()


    }

	override func configureView() {

		let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
		self.navigationItem.backBarButtonItem = backBarButton
		navigationController?.navigationBar.tintColor = .white
		self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]



		self.mainView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
	}

	@objc func startButtonClicked() {
		print("hi")
		navigationController?.pushViewController(CodeProfileSettingViewController(), animated: true)
	}




}
