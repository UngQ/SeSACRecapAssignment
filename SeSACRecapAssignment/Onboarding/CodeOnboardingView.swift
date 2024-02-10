//
//  CodeOnboardingView.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/10/24.
//

import UIKit
import SnapKit


class CodeOnboardingView: BaseView {

	let logoImageView = UIImageView()
	let mainImageView = UIImageView()
	let startButton = UIButton()

	override func configureHierarchy() {
		addSubview(mainImageView)
		addSubview(logoImageView)

		addSubview(startButton)
	}

	override func configureLayout() {
		mainImageView.snp.makeConstraints{ make in
			make.centerX.centerY.equalToSuperview()
			make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
			make.height.equalTo(mainImageView.snp.width)
		}

		logoImageView.snp.makeConstraints { make in
			make.bottom.equalTo(mainImageView.snp.top)
			make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
			make.height.equalTo(logoImageView.snp.width).multipliedBy(0.5)
		}



		startButton.snp.makeConstraints { make in
			make.bottom.equalTo(safeAreaLayoutGuide)
			make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
			make.height.equalTo(52)
		}
	}

	override func configureView() {


		backgroundColor = .sesacBackground

		logoImageView.image = .sesacShopping
		logoImageView.contentMode = .bottom
		mainImageView.image = .onboarding
		mainImageView.contentMode = .scaleAspectFill

		startButton.setTitle("시작하기", for: .normal)
		startButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
		startButton.backgroundColor = .sesacPoint
		startButton.layer.cornerRadius = 5
		startButton.layer.masksToBounds = true
	}

}
