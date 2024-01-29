//
//  CodeProfileImageCollectionViewCell.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/29/24.
//

import UIKit
import SnapKit

class CodeProfileImageCollectionViewCell: UICollectionViewCell {

	let profileImage = ProfileImageView(frame: .zero)

	override init(frame: CGRect) {
		super.init(frame: frame)
		configureHierarchy()
		configureConstraints()
		configureCell()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configureHierarchy() {
		contentView.addSubview(profileImage)
	}

	func configureCell() {

	}

	func configureConstraints() {

		profileImage.snp.makeConstraints { make in
			make.size.equalToSuperview()
		}
	}
}
