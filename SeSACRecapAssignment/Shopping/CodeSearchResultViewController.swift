//
//  CodeSearchResultViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/11/24.
//

import UIKit
import Kingfisher
import Alamofire

enum ButtonTitle: String {
	case first = " 정확도 "
	case second = " 날짜순 "
	case third = " 가격높은순 "
	case fourth = " 가격낮은순 "

	var sort: String {
		switch self {
		case .first:
			return "sim"
		case .second:
			return "date"
		case .third:
			return "dsc"
		case .fourth:
			return "asc"
		}
	}
}

class CodeSearchResultViewController: BaseViewController {


	var itemList: Shopping = Shopping(lastBuildDate: "", total: 0, start: 0, display: 0, items: [])
	var itemNumber = 1
	var lastPage = 1
	var currentSelected: ButtonTitle = .first

	static var product = Item(title: "", link: "", image: "", lprice: "", hprice: "", mallName: "", productId: "", productType: "", brand: "", maker: "", category1: "", category2: "", category3: "", category4: "")


	let mainView = CodeSearchResultView()
	let viewModel = CodeSearchResultViewModel()


	override func loadView() {
		view = mainView
	}

	override func viewWillAppear(_ animated: Bool) {
		mainView.searchResultCollectionView.reloadData()
	}

    override func viewDidLoad() {
        super.viewDidLoad()

    }

	func bindData() {
		viewModel.inputItemText.bind { value in
			<#code#>
		}
	}

	override func configureView() {
		navigationItem.title = CodeSearchViewController.searchItem
		navigationController?.navigationBar.tintColor = .white

		designButton(button: mainView.firstButton, title: ButtonTitle.first.rawValue, active: true)
		designButton(button: mainView.secondButton, title: ButtonTitle.second.rawValue, active: false)
		designButton(button: mainView.thirdButton, title: ButtonTitle.third.rawValue, active: false)
		designButton(button: mainView.fourthButton, title: ButtonTitle.fourth.rawValue, active: false)

		mainView.firstButton.addTarget(self, action: #selector(firstButtonClicked), for: .touchUpInside)
		mainView.secondButton.addTarget(self, action: #selector(secondButtonClicked), for: .touchUpInside)
		mainView.thirdButton.addTarget(self, action: #selector(thirdButtonClicked), for: .touchUpInside)
		mainView.fourthButton.addTarget(self, action: #selector(fourthButtonClicked), for: .touchUpInside)

		mainView.searchResultCollectionView.dataSource = self
		mainView.searchResultCollectionView.delegate = self
		mainView.searchResultCollectionView.prefetchDataSource = self
		mainView.searchResultCollectionView.register(CodeSearchResultCollectionViewCell.self, forCellWithReuseIdentifier: CodeSearchResultCollectionViewCell.identifier)

		callRequest(text: CodeSearchViewController.searchItem, sort: currenSelected.sort)

	}

	@objc func firstButtonClicked() {
		designButton(button: mainView.firstButton, title: ButtonTitle.first.rawValue, active: true)
		designButton(button: mainView.secondButton, title: ButtonTitle.second.rawValue, active: false)
		designButton(button: mainView.thirdButton, title: ButtonTitle.third.rawValue, active: false)
		designButton(button: mainView.fourthButton, title: ButtonTitle.fourth.rawValue, active: false)
		itemNumber = 1
		currentSelected = .first
		callRequest(text: CodeSearchViewController.searchItem, sort: currenSelected.sort)
	}

	@objc func secondButtonClicked() {
		designButton(button: mainView.firstButton, title: ButtonTitle.first.rawValue, active: false)
		designButton(button: mainView.secondButton, title: ButtonTitle.second.rawValue, active: true)
		designButton(button: mainView.thirdButton, title: ButtonTitle.third.rawValue, active: false)
		designButton(button: mainView.fourthButton, title: ButtonTitle.fourth.rawValue, active: false)
		itemNumber = 1
		currentSelected = .second
		callRequest(text: CodeSearchViewController.searchItem, sort: currenSelected.sort)
	}

	@objc func thirdButtonClicked() {
		designButton(button: mainView.firstButton, title: ButtonTitle.first.rawValue, active: false)
		designButton(button: mainView.secondButton, title: ButtonTitle.second.rawValue, active: false)
		designButton(button: mainView.thirdButton, title: ButtonTitle.third.rawValue, active: true)
		designButton(button: mainView.fourthButton, title: ButtonTitle.fourth.rawValue, active: false)
		itemNumber = 1
		currentSelected = .third
		callRequest(text: CodeSearchViewController.searchItem, sort: currenSelected.sort)
	}

	@objc func fourthButtonClicked() {
		designButton(button: mainView.firstButton, title: ButtonTitle.first.rawValue, active: false)
		designButton(button: mainView.secondButton, title: ButtonTitle.second.rawValue, active: false)
		designButton(button: mainView.thirdButton, title: ButtonTitle.third.rawValue, active: false)
		designButton(button: mainView.fourthButton, title: ButtonTitle.fourth.rawValue, active: true)
		itemNumber = 1
		currentSelected = .fourth
		callRequest(text: CodeSearchViewController.searchItem, sort: currenSelected.sort)
	}
}





extension CodeSearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		return itemList.items.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = mainView.searchResultCollectionView.dequeueReusableCell(withReuseIdentifier: CodeSearchResultCollectionViewCell.identifier, for: indexPath) as! CodeSearchResultCollectionViewCell
		let url = URL(string: itemList.items[indexPath.row].image)

		cell.itemImageView.kf.setImage(with: url)

		cell.mallNameLabel.text = itemList.items[indexPath.row].mallName


		cell.titleLabel.text = CodeSearchResultViewController.htmlToString(title: itemList.items[indexPath.row].title)


		cell.lpriceLabel.text = CodeSearchResultViewController.stringNumberFormatter(number: itemList.items[indexPath.row].lprice)

		cell.likeButton.tag = indexPath.row
		cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)


		if CodeSearchViewController.wishList.contains(where: { $0.productId == itemList.items[indexPath.row].productId }) {
			// 'like' 상태일 때
			cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)

		} else {
			// 'like' 상태가 아닐 때
			cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
		}

		cell.likeButton.tintColor = .black

		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		CodeSearchResultViewController.product = itemList.items[indexPath.row]

		navigationController?.pushViewController(CodeProductWebViewController(), animated: true)
	}

	@objc func likeButtonClicked(sender: UIButton) {
		if let index = CodeSearchViewController.wishList.firstIndex(where: { $0.productId == itemList.items[sender.tag].productId }) {
			CodeSearchViewController.wishList.remove(at: index)
		} else {
			CodeSearchViewController.wishList.append(itemList.items[sender.tag])
		}
		CodeSearchViewController.saveStructUserDefaults()
		CodeSearchViewController.loadStructUserDefaults()
		print(CodeSearchViewController.wishList)

		mainView.searchResultCollectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
	}
}

extension CodeSearchResultViewController: UICollectionViewDataSourcePrefetching {

	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

		for item in indexPaths {
			if itemList.items.count - 6 == item.row {
				itemNumber += 30
				callRequest(text: CodeSearchViewController.searchItem, sort: currenSelected.sort)
			}
		}
	}
}

extension CodeSearchResultViewController {

	func designButton(button: UIButton, title: String, active: Bool) {

		if active == true {
			button.backgroundColor = .white
			button.setTitleColor(.black, for: .normal)
		} else {
			button.backgroundColor = .black
			button.setTitleColor(.white, for: .normal)
		}

		button.setTitle(title, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 13)
		button.layer.masksToBounds = true
		button.layer.cornerRadius = 10
		button.layer.borderColor = UIColor.white.cgColor
		button.layer.borderWidth = 1

	}



	func intNumberFormatter(number: Int?) -> String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		let intPrice = number
		let formattedSave = formatter.string(for: intPrice)!

		return formattedSave
	}

	static func stringNumberFormatter(number: String?) -> String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		let stringPrice = number
		let intPrice = Int(stringPrice!)
		let formattedSave = formatter.string(for: intPrice)!

		return formattedSave
	}

	static func htmlToString(title: String) -> String {
		let html = title

		guard let data = html.data(using: .utf8) else {
			return ""
		}

		do {
			let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
			return attributedString.string
		} catch {
			return ""
		}
	}

}
