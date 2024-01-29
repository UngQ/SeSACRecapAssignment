//
//  ProfileImageUIButton.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/29/24.
//

import UIKit
import SnapKit

class ProfileImageView: UIImageView {


	override init(frame: CGRect) {
		super.init(frame: frame)

		configureButton()

	}

	private func configureButton() {
		layer.masksToBounds = true
		contentMode = .scaleAspectFit
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = bounds.size.width / 2
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
