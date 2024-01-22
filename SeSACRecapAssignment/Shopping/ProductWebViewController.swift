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

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.title = "\(UserDefaults.standard.string(forKey: "Title")!)"

    let image = like ? "heart.fill" : "heart"
    let item = UIBarButtonItem(image: UIImage(systemName: image), style: .plain, target: self, action: #selector(heartButtonClicked))
    navigationItem.rightBarButtonItem = item

    view.backgroundColor = .sesacBackground
    if let url = URL(string: url(productId)) {

      let request = URLRequest(url: url)

      webView.load(request)
    }
  }

  @objc func heartButtonClicked() {
    like.toggle()
    if like {
      navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
    } else {
      navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
    }
    UserDefaults.standard.setValue(like, forKey: "Like")
  }


  func url(_ productId: String) -> String {
    return "https://msearch.shopping.naver.com/product/\(productId)"
  }

}
