//
//  WishListViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/26/24.
//

import UIKit

class WishListViewController: UIViewController {

	@IBOutlet var wishListCollectionView: UICollectionView!

	var itemList: Shopping = Shopping(lastBuildDate: "", total: 0, start: 0, display: 0, items: [])

	override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .sesacBackground
		navigationItem.title = "위시 리스트"
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.sesacText.cgColor]

		let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
		self.navigationItem.backBarButtonItem = backBarButton
		self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]


		wishListCollectionView.delegate = self
		wishListCollectionView.dataSource = self

		


		let xib = UINib(nibName: ResultCollectionViewCell.identifier, bundle: nil)
		wishListCollectionView.register(xib, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)

		let layout = UICollectionViewFlowLayout()
		let spacing: CGFloat = 12
		let cellWidth = UIScreen.main.bounds.width - (spacing * 3)

		layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 2 + 86)
		layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
		layout.minimumLineSpacing = spacing
		layout.minimumInteritemSpacing = 0
		layout.scrollDirection = .vertical
		wishListCollectionView.backgroundColor = .clear

		wishListCollectionView.collectionViewLayout = layout

    }

	override func viewWillAppear(_ animated: Bool) {
		wishListCollectionView.reloadData()
	}


}


extension WishListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		print(CodeSearchViewController.wishList.count)
		return CodeSearchViewController.wishList.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


		let cell = wishListCollectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as! ResultCollectionViewCell

		cell.backgroundColor = .clear
		let url = URL(string: CodeSearchViewController.wishList[indexPath.row].image)

		cell.itemImageView.kf.setImage(with: url)
		cell.itemImageView.contentMode = .scaleAspectFill
		cell.itemImageView.layer.masksToBounds = true
		cell.itemImageView.layer.cornerRadius = 10

		cell.mallNameLabel.text = CodeSearchViewController.wishList[indexPath.row].mallName
		cell.mallNameLabel.textColor = .systemGray2
		cell.mallNameLabel.font = .systemFont(ofSize: 13)

		cell.titleLabel.text = SearchResultViewController.htmlToString(title: CodeSearchViewController.wishList[indexPath.row].title)
		cell.titleLabel.textColor = .systemGray4
		cell.titleLabel.font = .systemFont(ofSize: 13)
		cell.titleLabel.numberOfLines = 2

		cell.lpriceLabel.text = SearchResultViewController.stringNumberFormatter(number: CodeSearchViewController.wishList[indexPath.row].lprice)
		cell.lpriceLabel.textColor = .sesacText
		cell.lpriceLabel.font = .boldSystemFont(ofSize: 14)

		cell.likeButton.tag = indexPath.row
		cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
		cell.likeButton.backgroundColor = .white
		cell.likeButton.layer.masksToBounds = true
		cell.likeButton.layer.cornerRadius = 16

		cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)


		cell.likeButton.tintColor = .black

		return cell

	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		SearchResultViewController.product = CodeSearchViewController.wishList[indexPath.row]


		let vc = storyboard?.instantiateViewController(withIdentifier: ProductWebViewController.identifier) as! ProductWebViewController
		navigationController?.pushViewController(vc, animated: true)
	}

	@objc func likeButtonClicked(sender: UIButton) {
		CodeSearchViewController.wishList.remove(at: sender.tag)

		CodeSearchViewController.saveStructUserDefaults()
		CodeSearchViewController.loadStructUserDefaults()

		wishListCollectionView.reloadData()

	}


}
