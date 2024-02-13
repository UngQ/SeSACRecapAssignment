//
//  SearchResultViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/21/24.
//

import UIKit
import Alamofire
import Kingfisher

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

class SearchResultViewController: UIViewController {

	@IBOutlet var totalLabel: UILabel!

	@IBOutlet var firstButton: UIButton!
	@IBOutlet var secondButton: UIButton!
	@IBOutlet var thirdButton: UIButton!
	@IBOutlet var fourthButton: UIButton!

	@IBOutlet var searchResultCollectionView: UICollectionView!

	var itemList: Shopping = Shopping(lastBuildDate: "", total: 0, start: 0, display: 0, items: [])
	var itemNumber = 1
	var lastPage = 1
	var currenSelected: ButtonTitle = .first

	static var product = Item(title: "", link: "", image: "", lprice: "", hprice: "", mallName: "", productId: "", productType: "", brand: "", maker: "", category1: "", category2: "", category3: "", category4: "")

	override func viewWillAppear(_ animated: Bool) {
		searchResultCollectionView.reloadData()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .black

		configureView()

		designButton(button: firstButton, title: ButtonTitle.first.rawValue, active: true)
		designButton(button: secondButton, title: ButtonTitle.second.rawValue, active: false)
		designButton(button: thirdButton, title: ButtonTitle.third.rawValue, active: false)
		designButton(button: fourthButton, title: ButtonTitle.fourth.rawValue, active: false)
	}

	@IBAction func firstButtonClicked(_ sender: UIButton) {
		designButton(button: firstButton, title: ButtonTitle.first.rawValue, active: true)
		designButton(button: secondButton, title: ButtonTitle.second.rawValue, active: false)
		designButton(button: thirdButton, title: ButtonTitle.third.rawValue, active: false)
		designButton(button: fourthButton, title: ButtonTitle.fourth.rawValue, active: false)
		itemNumber = 1
		currenSelected = .first
		callRequest(text: CodeSearchViewController.searchItem, sort: currenSelected.sort)
	}

	@IBAction func secondButtonClicked(_ sender: UIButton) {
		designButton(button: firstButton, title: ButtonTitle.first.rawValue, active: false)
		designButton(button: secondButton, title: ButtonTitle.second.rawValue, active: true)
		designButton(button: thirdButton, title: ButtonTitle.third.rawValue, active: false)
		designButton(button: fourthButton, title: ButtonTitle.fourth.rawValue, active: false)
		itemNumber = 1
		currenSelected = .second
		callRequest(text: CodeSearchViewController.searchItem, sort: currenSelected.sort)
	}

	@IBAction func thirdButtonClicked(_ sender: UIButton) {
		designButton(button: firstButton, title: ButtonTitle.first.rawValue, active: false)
		designButton(button: secondButton, title: ButtonTitle.second.rawValue, active: false)
		designButton(button: thirdButton, title: ButtonTitle.third.rawValue, active: true)
		designButton(button: fourthButton, title: ButtonTitle.fourth.rawValue, active: false)
		itemNumber = 1
		currenSelected = .third
		callRequest(text: CodeSearchViewController.searchItem, sort: currenSelected.sort)
	}


	@IBAction func fourthButtonClicked(_ sender: UIButton) {
		designButton(button: firstButton, title: ButtonTitle.first.rawValue, active: false)
		designButton(button: secondButton, title: ButtonTitle.second.rawValue, active: false)
		designButton(button: thirdButton, title: ButtonTitle.third.rawValue, active: false)
		designButton(button: fourthButton, title: ButtonTitle.fourth.rawValue, active: true)
		itemNumber = 1
		currenSelected = .fourth
		callRequest(text: CodeSearchViewController.searchItem, sort: currenSelected.sort)
	}



	func callRequest(text: String, sort: String) {
		let url = "https://openapi.naver.com/v1/search/shop.json"

		let headers: HTTPHeaders = [
			"X-Naver-Client-Id": APIKey.clientID,
			"X-Naver-Client-Secret": APIKey.clientSecret
		]


		let parameters: Parameters = [
			"query": text,
			"start": itemNumber,
			"display": "30",
			"sort": sort
		]

		AF.request(url, method: .get, parameters: parameters, headers: headers).responseDecodable(of: Shopping.self) { response in
			switch response.result {
			case .success(let success):


				if success.items.count == 0 {
					self.totalLabel.text = "검색 결과가 없습니다"

					self.searchResultCollectionView.reloadData()
				} else {

					if self.itemNumber == 1 {
						self.itemList = success
						self.lastPage = success.total / 30

						self.totalLabel.text = "\(self.intNumberFormatter(number: success.total)) 개의 검색 결과"

					} else {

						self.itemList.items.append(contentsOf: success.items)
					}

					self.searchResultCollectionView.reloadData()

					if self.itemNumber == 1 {
						self.searchResultCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)

					}
				}

			case .failure(let failure):
				print(failure)
			}
		}
	}
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		return itemList.items.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = searchResultCollectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
		let url = URL(string: itemList.items[indexPath.row].image)
		cell.backgroundColor = .clear

		cell.itemImageView.kf.setImage(with: url)
		cell.itemImageView.contentMode = .scaleAspectFill
		cell.itemImageView.layer.masksToBounds = true
		cell.itemImageView.layer.cornerRadius = 10

		cell.mallNameLabel.text = itemList.items[indexPath.row].mallName
		cell.mallNameLabel.textColor = .systemGray2
		cell.mallNameLabel.font = .systemFont(ofSize: 13)

		cell.titleLabel.text =  SearchResultViewController.htmlToString(title: itemList.items[indexPath.row].title)
		cell.titleLabel.textColor = .systemGray4
		cell.titleLabel.font = .systemFont(ofSize: 13)
		cell.titleLabel.numberOfLines = 2

		cell.lpriceLabel.text = SearchResultViewController.stringNumberFormatter(number: itemList.items[indexPath.row].lprice)
		cell.lpriceLabel.textColor = .sesacText
		cell.lpriceLabel.font = .boldSystemFont(ofSize: 14)

		cell.likeButton.tag = indexPath.row
		cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
		cell.likeButton.backgroundColor = .white
		cell.likeButton.layer.masksToBounds = true
		cell.likeButton.layer.cornerRadius = 16

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
		SearchResultViewController.product = itemList.items[indexPath.row]


		let vc = storyboard?.instantiateViewController(withIdentifier: ProductWebViewController.identifier) as! ProductWebViewController
		navigationController?.pushViewController(vc, animated: true)
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

		searchResultCollectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
	}
}




//내가 만든 기능
extension SearchResultViewController {
	func configureView() {
		navigationItem.title = CodeSearchViewController.searchItem

		searchResultCollectionView.dataSource = self
		searchResultCollectionView.delegate = self
		searchResultCollectionView.prefetchDataSource = self

		totalLabel.font = .boldSystemFont(ofSize: 13)
		totalLabel.textColor = .sesacPoint

		let layout = UICollectionViewFlowLayout()
		let spacing: CGFloat = 12
		let cellWidth = UIScreen.main.bounds.width - (spacing * 3)

		layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 2 + 86)
		layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
		layout.minimumLineSpacing = spacing
		layout.minimumInteritemSpacing = 0
		layout.scrollDirection = .vertical
		searchResultCollectionView.backgroundColor = .clear

		searchResultCollectionView.collectionViewLayout = layout


		NaverShoppingAPIManager.shared.request(text: CodeSearchViewController.searchItem, sort: currenSelected.sort, itemNumber: itemNumber) { success in

			dump(success)
			DispatchQueue.main.async {
			if success.items.count == 0 {
				self.totalLabel.text = "검색 결과가 없습니다"

				self.searchResultCollectionView.reloadData()
			} else {

				if self.itemNumber == 1 {
					self.itemList = success
					self.lastPage = success.total / 30

					self.totalLabel.text = "\(self.intNumberFormatter(number: success.total)) 개의 검색 결과"

				} else {

					self.itemList.items.append(contentsOf: success.items)
				}

				self.searchResultCollectionView.reloadData()

				if self.itemNumber == 1 {
					self.searchResultCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
				}
				}
			}
		}

//		callRequest(text: SearchViewController.searchItem, sort: currenSelected.sort)

	}

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


extension SearchResultViewController: UICollectionViewDataSourcePrefetching {

	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

		for item in indexPaths {
			if itemList.items.count - 6 == item.row {
				itemNumber += 30
				callRequest(text: CodeSearchViewController.searchItem, sort: currenSelected.sort)
			}
		}
	}
}

