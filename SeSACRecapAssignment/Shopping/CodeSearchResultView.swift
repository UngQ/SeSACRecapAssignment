//
//  CodeSearchResultView.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/11/24.
//

import UIKit
import SnapKit

class CodeSearchResultView: BaseView {

	let totalLabel = UILabel()
	let firstButton = UIButton()
	let secondButton = UIButton()
	let thirdButton = UIButton()
	let fourthButton = UIButton()

	let searchResultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())


	override func configureHierarchy() {
		addSubview(totalLabel)
		addSubview(firstButton)
		addSubview(secondButton)
		addSubview(thirdButton)
		addSubview(fourthButton)
		addSubview(searchResultCollectionView)
	}

	override func configureLayout() {
		totalLabel.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide)
			make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
			make.height.equalTo(28)
		}
		
		firstButton.snp.makeConstraints { make in
			make.width.greaterThanOrEqualTo(10)
			make.height.equalTo(32)
			make.leading.equalTo(safeAreaLayoutGuide).offset(8)
			make.top.equalTo(totalLabel.snp.bottom).offset(4)
		}
		
		secondButton.snp.makeConstraints { make in
			make.width.greaterThanOrEqualTo(10)
			make.height.equalTo(32)
			make.leading.equalTo(firstButton.snp.trailing).offset(8)
			make.top.equalTo(totalLabel.snp.bottom).offset(4)
		}
		
		thirdButton.snp.makeConstraints { make in
			make.width.greaterThanOrEqualTo(10)
			make.height.equalTo(32)
			make.leading.equalTo(secondButton.snp.trailing).offset(8)
			make.top.equalTo(totalLabel.snp.bottom).offset(4)
		}
		
		fourthButton.snp.makeConstraints { make in
			make.width.greaterThanOrEqualTo(10)
			make.height.equalTo(32)
			make.leading.equalTo(thirdButton.snp.trailing).offset(8)
			make.top.equalTo(totalLabel.snp.bottom).offset(4)
		}
		
		searchResultCollectionView.snp.makeConstraints { make in
			make.top.equalTo(firstButton.snp.bottom).offset(8)
			make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
		}
	}

	override func configureView() {
		totalLabel.font = .boldSystemFont(ofSize: 13)
		totalLabel.textColor = .sesacPoint


		searchResultCollectionView.backgroundColor = .clear
		searchResultCollectionView.collectionViewLayout = CodeSearchResultView.configureCollectionView()
	}

	static func configureCollectionView() -> UICollectionViewFlowLayout {


		let layout = UICollectionViewFlowLayout()
		let spacing: CGFloat = 12
		let cellWidth = UIScreen.main.bounds.width - (spacing * 3)

		layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 2 + 78)
		layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
		layout.minimumLineSpacing = spacing
		layout.minimumInteritemSpacing = 0
		layout.scrollDirection = .vertical

		return layout

	}

}

