//
//  CodeWishViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/13/24.
//

import UIKit

class CodeWishViewController: BaseViewController {

	let mainView = CodeWishView()

	override func loadView() {
		view = mainView
	}

	override func viewWillAppear(_ animated: Bool) {
		mainView.wishCollectionView.reloadData()
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		navigationItem.title = "위시 리스트"
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.sesacText.cgColor]

		let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
		self.navigationItem.backBarButtonItem = backBarButton
		self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

		mainView.wishCollectionView.delegate = self
		mainView.wishCollectionView.dataSource = self
		mainView.wishCollectionView.register(CodeSearchResultCollectionViewCell.self, forCellWithReuseIdentifier: CodeSearchResultCollectionViewCell.identifier)



    }
    

}

extension CodeWishViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return CodeSearchViewController.wishList.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = mainView.wishCollectionView.dequeueReusableCell(withReuseIdentifier: CodeSearchResultCollectionViewCell.identifier, for: indexPath) as! CodeSearchResultCollectionViewCell

		let url = URL(string: CodeSearchViewController.wishList[indexPath.row].image)
		cell.itemImageView.kf.setImage(with: url)

		cell.mallNameLabel.text = CodeSearchViewController.wishList[indexPath.row].mallName

		cell.titleLabel.text = CodeSearchResultViewController.htmlToString(title: CodeSearchViewController.wishList[indexPath.row].title)

		cell.lpriceLabel.text = CodeSearchResultViewController.stringNumberFormatter(number: CodeSearchViewController.wishList[indexPath.row].lprice)

		cell.likeButton.tag = indexPath.row
		cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)

		cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)



		return cell

	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		CodeSearchResultViewController.product = CodeSearchViewController.wishList[indexPath.row]
		navigationController?.pushViewController(CodeProductWebViewController(), animated: true)

	}

	@objc func likeButtonClicked(sender: UIButton) {
		CodeSearchViewController.wishList.remove(at: sender.tag)

		CodeSearchViewController.saveStructUserDefaults()
		CodeSearchViewController.loadStructUserDefaults()

		mainView.wishCollectionView.reloadData()

	}


	
}
