//
//  BaseView.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/10/24.
//

import UIKit

class BaseView: UIView {


	override init(frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = .sesacBackground

		configureHierarchy()
		configureLayout()
		configureView()
	}

	func configureHierarchy() {

	}

	func configureLayout() {

	}

	func configureView() {

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
