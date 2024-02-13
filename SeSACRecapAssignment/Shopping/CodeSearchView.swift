//
//  CodeSearchView.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/11/24.
//

import UIKit

class CodeSearchView: BaseView {
	
	let searchBar = UISearchBar()

	let emptyImageView = UIImageView()
	let emptyLabel = UILabel()

	var currentSearchLabel = UILabel()

	var allDeleteButton = UIButton()

	var searchTableView = UITableView()



	override func configureHierarchy() {
		addSubview(searchBar)
		addSubview(emptyImageView)
		addSubview(emptyLabel)
		addSubview(currentSearchLabel)
		addSubview(allDeleteButton)
		addSubview(searchTableView)
	}

	override func configureLayout() {
		searchBar.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide)
			make.leading.equalTo(4)
			make.trailing.equalTo(-4)
		}

		emptyImageView.snp.makeConstraints { make in
			make.centerX.centerY.equalToSuperview()
		}

		emptyLabel.snp.makeConstraints { make in
			make.top.equalTo(emptyImageView.snp.bottom).offset(8)
			make.centerX.equalToSuperview()
		}

		currentSearchLabel.snp.makeConstraints { make in
			make.top.equalTo(searchBar.snp.bottom).offset(8)
			make.leading.equalTo(4)

		}

		allDeleteButton.snp.makeConstraints { make in
			make.top.equalTo(searchBar.snp.bottom).offset(8)
			make.trailing.equalTo(-4)
		}

		searchTableView.snp.makeConstraints { make in
			make.top.equalTo(currentSearchLabel.snp.bottom).offset(4)
			make.trailing.equalTo(0)
			make.leading.equalTo(0)
			make.bottom.equalToSuperview()
		}
	}


	override func configureView() {
		searchTableView.backgroundColor = .clear
		searchTableView.separatorStyle = .singleLine
		searchTableView.separatorColor = .white
	}
}
