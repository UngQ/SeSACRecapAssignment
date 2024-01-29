//
//  CodeSearchTableViewCell.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/29/24.
//


import UIKit
import SnapKit



class CodeSearchTableViewCell: UITableViewCell {
	let currentSearchTextLabel = UILabel()
	let magnifyingglassButton = UIButton()
	let xmarkButton = UIButton()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		self.addSubview(currentSearchTextLabel)
		self.addSubview(magnifyingglassButton)
		self.addSubview(xmarkButton)

		backgroundColor = .clear

		currentSearchTextLabel.textColor = .sesacText
		currentSearchTextLabel.font = .systemFont(ofSize: 13)

		magnifyingglassButton.setTitle("", for: .normal)
		magnifyingglassButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)

		xmarkButton.setTitle("", for: .normal)
		xmarkButton.setImage(UIImage(systemName: "xmark"), for: .normal)
		xmarkButton.contentMode = .center

		magnifyingglassButton.snp.makeConstraints { make in
			make.height.equalToSuperview()
			make.width.equalTo(magnifyingglassButton.snp.height)
			make.top.equalTo(self.safeAreaLayoutGuide)
			make.leading.equalTo(4)
			make.bottom.equalTo(self.safeAreaLayoutGuide)


		}
		currentSearchTextLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.height.equalToSuperview()
			make.trailing.equalTo(xmarkButton.snp.leading).inset(4)
			make.leading.equalTo(magnifyingglassButton.snp.trailing).offset(4)
		}

		xmarkButton.snp.makeConstraints { make in
			make.height.equalToSuperview()
			make.width.equalTo(magnifyingglassButton.snp.height)
			make.top.equalTo(self.safeAreaLayoutGuide)
			make.trailing.equalTo(-4)
			make.bottom.equalTo(self.safeAreaLayoutGuide)
		}

	}



	required init?(coder: NSCoder) {

		fatalError()

	}



	override func awakeFromNib() {

		super.awakeFromNib()

		}





}
