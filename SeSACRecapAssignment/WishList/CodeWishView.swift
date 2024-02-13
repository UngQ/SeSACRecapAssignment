//
//  CodeWishView.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/13/24.
//

import UIKit
import SnapKit

class CodeWishView: BaseView {

	let wishCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

	override func configureHierarchy() {
		addSubview(wishCollectionView)
	}

	override func configureLayout() {
		wishCollectionView.snp.makeConstraints { make in
			make.edges.equalTo(safeAreaLayoutGuide)
		}
	}

	override func configureView() {
		backgroundColor = .sesacBackground

		wishCollectionView.backgroundColor = .clear
		wishCollectionView.collectionViewLayout = CodeSearchResultView.configureCollectionView()
	}
}
