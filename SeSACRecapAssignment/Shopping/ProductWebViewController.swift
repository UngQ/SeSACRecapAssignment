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
  let productId = UserDefaults.standard.string(forKey: "ProductId")!
  let itemTitle = UserDefaults.standard.string(forKey: "Title")
  var like = UserDefaults.standard.bool(forKey: "Like")
    var count = UserDefaults.standard.dictionary(forKey: "Count") as? [String: Bool]

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "\(UserDefaults.standard.string(forKey: "Title")!)"

      if let isLiked = count?[productId] as? Bool, isLiked {
          let item = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(heartButtonClicked))
          navigationItem.rightBarButtonItem = item
      } else {
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
        if var updatedCount = UserDefaults.standard.dictionary(forKey: "Count") as? [String: Bool] {
            if updatedCount[productId] == true {
                updatedCount[productId] = nil
            } else {
                updatedCount[productId] = true
            }
            UserDefaults.standard.set(updatedCount, forKey: "Count")

            if updatedCount[productId] == true {
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            } else {
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            }
        }
    }


  func url(_ productId: String) -> String {
    return "https://msearch.shopping.naver.com/product/\(productId)"
  }

}
