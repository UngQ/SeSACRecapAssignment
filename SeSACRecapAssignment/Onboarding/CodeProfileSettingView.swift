//
//  CodeProfileSettingView.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/10/24.
//

import UIKit

class CodeProfileSettingView: BaseView {


	let profileImageView = ProfileImageView(frame: .zero)
	let nicknameView = UIView()
	let inputTextField = UITextField()
	let lineView = UIView()
	let alertLabel = UILabel()

	let okButton = UIButton()



	override func configureHierarchy() {
		addSubview(profileImageView)
		addSubview(nicknameView)
		nicknameView.addSubview(inputTextField)
		nicknameView.addSubview(lineView)
		nicknameView.addSubview(alertLabel)
		addSubview(okButton)
	}

	override func configureLayout() {
		profileImageView.snp.makeConstraints { make in
			make.size.equalTo(160)
			make.centerX.equalToSuperview()
			make.top.equalTo(safeAreaLayoutGuide).offset(20)
		}

		nicknameView.snp.makeConstraints { make in
			make.top.equalTo(profileImageView.snp.bottom).offset(20)
			make.horizontalEdges.equalToSuperview().inset(8)
			make.height.equalTo(120)
		}

		lineView.snp.makeConstraints { make in
			make.centerX.centerY.equalToSuperview()
			make.height.equalTo(1)
			make.width.equalToSuperview()
		}

		inputTextField.snp.makeConstraints { make in
			make.top.horizontalEdges.equalToSuperview().inset(8)
			make.bottom.equalTo(lineView.snp.top).offset(-8)
		}

		alertLabel.snp.makeConstraints { make in
			make.bottom.horizontalEdges.equalToSuperview().inset(8)
			make.top.equalTo(lineView.snp.bottom).offset(8)
		}

		okButton.snp.makeConstraints { make in
			make.top.equalTo(nicknameView.snp.bottom).offset(8)
			make.horizontalEdges.equalToSuperview().inset(8)
			make.height.equalTo(52)
		}
	}

	override func configureView() {
		profileImageView.backgroundColor = .green

		nicknameView.backgroundColor = .blue
		lineView.backgroundColor = .white

		inputTextField.backgroundColor = .brown
		alertLabel.backgroundColor = .brown

		okButton.backgroundColor = .gray
	}


}
