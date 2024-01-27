//
//  ProductWebViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/22/24.
//

import UIKit
import WebKit

class ProductWebViewController: UIViewController {

	@IBOutlet var webView: WKWebView!

	let productId = SearchResultViewController.product.productId
	let itemTitle = SearchResultViewController.product.title

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.title = SearchResultViewController.htmlToString(title: itemTitle)
		

		if SearchViewController.wishList.contains(where: { $0.productId == productId }) {
			// 'like' 상태일 때
			let item = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(heartButtonClicked))
			navigationItem.rightBarButtonItem = item
		} else {
			// 'like' 상태가 아닐 때
			let item = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(heartButtonClicked))
			navigationItem.rightBarButtonItem = item
		}

		view.backgroundColor = .sesacBackground

		if let url = URL(string: url(productId)) {

			let request = URLRequest(url: url)

			webView.load(request)
		}
	}

	@objc func heartButtonClicked() {

		if let index = SearchViewController.wishList.firstIndex(where: { $0.productId == productId }) {
			SearchViewController.wishList.remove(at: index)
			navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")

		} else {
			SearchViewController.wishList.append(SearchResultViewController.product)
			navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
		}
		SearchViewController.saveStructUserDefaults()
		SearchViewController.loadStructUserDefaults()

	}


	func url(_ productId: String) -> String {
		return "https://msearch.shopping.naver.com/product/\(productId)"
	}

}
