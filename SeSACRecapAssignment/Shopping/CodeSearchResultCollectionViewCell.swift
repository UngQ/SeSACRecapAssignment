//
//  CodeSearchResultCollectionViewCell.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/13/24.
//

import UIKit

class CodeSearchResultCollectionViewCell: UICollectionViewCell {

	let itemImageView = UIImageView()
	let likeButton = UIButton()
	let mallNameLabel = UILabel()
	let titleLabel = UILabel()
	let lpriceLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)

		configureHierarchy()
		configureLayout()
		configureCell()
	}
	


	func configureHierarchy() {
		addSubview(itemImageView)
		addSubview(likeButton)
		addSubview(mallNameLabel)
		addSubview(titleLabel)
		addSubview(lpriceLabel)
	}

	func configureLayout() {
		itemImageView.snp.makeConstraints { make in
			make.width.equalTo(safeAreaLayoutGuide)
			make.height.equalTo(itemImageView.snp.width)
			make.centerX.equalTo(safeAreaLayoutGuide)
		}

		likeButton.snp.makeConstraints { make in
			make.size.equalTo(28)
			make.trailing.equalTo(itemImageView.snp.trailing).offset(-4)
			make.top.equalTo(itemImageView.snp.top).offset(4)
		}

		mallNameLabel.snp.makeConstraints { make in
			make.height.lessThanOrEqualTo(16)
			make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(4)
			make.top.equalTo(itemImageView.snp.bottom).offset(4)
		}

		titleLabel.snp.makeConstraints { make in
			make.height.lessThanOrEqualTo(40)
			make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(4)
			make.top.equalTo(mallNameLabel.snp.bottom).offset(2)
		}

		lpriceLabel.snp.makeConstraints { make in
			make.height.lessThanOrEqualTo(20)
			make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(4)
			make.top.equalTo(titleLabel.snp.bottom).offset(2)
		}
	}


	func configureCell() {
		backgroundColor = .clear

		itemImageView.contentMode = .scaleAspectFill
		itemImageView.layer.masksToBounds = true
		itemImageView.layer.cornerRadius = 10

		mallNameLabel.textColor = .systemGray2
		mallNameLabel.font = .systemFont(ofSize: 13)

		titleLabel.textColor = .systemGray4
		titleLabel.font = .systemFont(ofSize: 13)
		titleLabel.numberOfLines = 2

		lpriceLabel.textColor = .sesacText
		lpriceLabel.font = .boldSystemFont(ofSize: 14)

		likeButton.backgroundColor = .white
		likeButton.tintColor = .black
		likeButton.layer.masksToBounds = true
		likeButton.layer.cornerRadius = 14

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
