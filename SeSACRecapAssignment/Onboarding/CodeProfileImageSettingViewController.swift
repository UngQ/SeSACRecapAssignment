//
//  CodeProfileImageSettingViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/29/24.
//

import UIKit


class CodeProfileImageSettingViewController: UIViewController {

	let selectedImageView = ProfileImageView(frame: .zero)
	let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())

    override func viewDidLoad() {
        super.viewDidLoad()


		configureHierarchy()
		configureConstraints()
		configureView()


    }

	static func configureCollectionViewLayout() -> UICollectionViewLayout {

		let layout = UICollectionViewFlowLayout()
		let spacing: CGFloat = 12
		let cellWidth = UIScreen.main.bounds.width - (spacing * 5)

		layout.itemSize = CGSize(width: cellWidth / 4, height: cellWidth / 4)
		layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
		layout.minimumLineSpacing = spacing
		layout.minimumInteritemSpacing = 0
		layout.scrollDirection = .vertical

		return layout

	}

	func configureHierarchy() {
		view.addSubview(selectedImageView)
		view.addSubview(collectionView)
	}

	func configureView() {
		view.backgroundColor = .sesacBackground
		navigationItem.title = "프로필 설정"

		let image = UserDefaults.standard.integer(forKey: UserDefaultsKey.imageNumber.rawValue)

		selectedImageView.image = UIImage(imageLiteralResourceName: 		ProfileImage.allCases[image].rawValue)

		collectionView.delegate = self
		collectionView.dataSource = self

		collectionView.register(CodeProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: CodeProfileImageCollectionViewCell.identifier)

		collectionView.backgroundColor = .clear

	}

	func configureConstraints() {
		selectedImageView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
			make.centerX.equalToSuperview()
			make.size.equalTo(120)
		}

		collectionView.snp.makeConstraints { make in
			make.top.equalTo(selectedImageView.snp.bottom).offset(16)
			make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
			make.bottom.equalTo(view.safeAreaLayoutGuide)
		}

	}

}


extension CodeProfileImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		return ProfileImage.allCases.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CodeProfileImageCollectionViewCell.identifier, for: indexPath) as! CodeProfileImageCollectionViewCell

		let image = UserDefaults.standard.integer(forKey: UserDefaultsKey.imageNumber.rawValue)

		if image == Int(indexPath.row) {
			cell.profileImage.layer.borderColor = UIColor.sesacPoint.cgColor
			cell.profileImage.layer.borderWidth = 4
		} else {
			cell.profileImage.layer.borderColor = UIColor.clear.cgColor
			cell.profileImage.layer.borderWidth = 0
		}

		cell.profileImage.image = UIImage(imageLiteralResourceName: ProfileImage.allCases[indexPath.row].rawValue)


		return cell
	}


	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		let cell = collectionView.cellForItem(at: indexPath) as! CodeProfileImageCollectionViewCell

		cell.profileImage.layer.borderColor = UIColor.sesacPoint.cgColor
		cell.profileImage.layer.borderWidth = 4

		selectedImageView.image = cell.profileImage.image

		UserDefaults.standard.setValue(indexPath.row, forKey: UserDefaultsKey.imageNumber.rawValue)

		print(indexPath.row)
		collectionView.reloadData()
	}
}
