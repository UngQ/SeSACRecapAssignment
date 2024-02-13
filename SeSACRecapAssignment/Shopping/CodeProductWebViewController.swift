//
//  CodeProductWebViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/13/24.
//

import UIKit
import WebKit
import SnapKit

class CodeProductWebViewController: BaseViewController {

	let webView = WKWebView()

	let productId = CodeSearchResultViewController.product.productId
	let itemTitle = CodeSearchResultViewController.product.title

    override func viewDidLoad() {
        super.viewDidLoad()
	}

	override func configureHierarchy() {
		view.addSubview(webView)
	}

	override func configureLayout() {
		webView.snp.makeConstraints { make in
			make.edges.equalTo(view.safeAreaLayoutGuide)
		}
	}

	override func configureView() {

		navigationItem.title = CodeSearchResultViewController.htmlToString(title: itemTitle)
		navigationController?.navigationBar.tintColor = .white


		if CodeSearchViewController.wishList.contains(where: { $0.productId == productId }) {
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

		if let index = CodeSearchViewController.wishList.firstIndex(where: { $0.productId == productId }) {
			CodeSearchViewController.wishList.remove(at: index)
			navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")

		} else {
			CodeSearchViewController.wishList.append(CodeSearchResultViewController.product)
			navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
		}
		CodeSearchViewController.saveStructUserDefaults()
		CodeSearchViewController.loadStructUserDefaults()
	}

	func url(_ productId: String) -> String {
		return "https://msearch.shopping.naver.com/product/\(productId)"
	}
}
