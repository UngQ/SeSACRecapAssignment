//
//  SearchViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/21/24.
//



import UIKit
import Alamofire
import Toast
import SnapKit

class CodeSearchViewController: UIViewController {

	static var searchItem = ""
	static var wishList: [Item] = []
	var searchHistory = UserDefaults.standard.array(forKey: "SearchHistory") as? [String] ?? []

	let mainView = CodeSearchView()

	override func loadView() {
		view = mainView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		CodeSearchViewController.loadStructUserDefaults()

		configureView()
		mainView.searchTableView.register(CodeSearchTableViewCell.self, forCellReuseIdentifier: "CodeSearchTableViewCell")
		mainView.allDeleteButton.addTarget(self, action: #selector(allDeleteButtonClicked), for: .touchUpInside)
	}

	override func viewWillAppear(_ animated: Bool) {
		navigationItem.title = "\(UserDefaults.standard.string(forKey: "Nickname")!)님의 새싹쇼핑"
		mainView.searchTableView.reloadData()
	}

	@objc func allDeleteButtonClicked() {
		searchHistory = []
		mainView.currentSearchLabel.isHidden = true
		mainView.allDeleteButton.isHidden = true
		mainView.emptyImageView.isHidden = false
		mainView.emptyLabel.isHidden = false
		view.endEditing(true)
		mainView.searchTableView.reloadData()
	}
}

extension CodeSearchViewController: UITabBarDelegate {

}

//서치바 관련
extension CodeSearchViewController: UISearchBarDelegate {

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		view.endEditing(true)

		if searchBar.text != "" {
			CodeSearchViewController.searchItem = searchBar.searchTextField.text!
			searchHistory.insert(searchBar.searchTextField.text!, at: 0)
			UserDefaults.standard.setValue(searchHistory, forKey: "SearchHistory")
			searchBar.text = ""

			mainView.emptyImageView.isHidden = true
			mainView.emptyLabel.isHidden = true
			mainView.currentSearchLabel.isHidden = false
			mainView.allDeleteButton.isHidden = false

			mainView.searchTableView.reloadData()

			navigationController?.pushViewController(CodeSearchResultViewController(), animated: true)

		} else {
			self.view.makeToast("검색어를 입력하세요!", position: .center)
		}
	}
}

//테이블뷰 관련
extension CodeSearchViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return searchHistory.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = mainView.searchTableView.dequeueReusableCell(withIdentifier: CodeSearchTableViewCell.identifier, for: indexPath) as! CodeSearchTableViewCell
		//수정
		cell.currentSearchTextLabel.text = searchHistory[indexPath.row]
		cell.xmarkButton.tag = indexPath.row
		cell.xmarkButton.addTarget(self, action: #selector(xmarkButtonClicked), for: .touchUpInside)

		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		56
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		CodeSearchViewController.searchItem = searchHistory[indexPath.row]
		searchHistory.remove(at: indexPath.row)
		searchHistory.insert(CodeSearchViewController.searchItem, at: 0)
		print(CodeSearchViewController.searchItem)

		tableView.reloadData()
		view.endEditing(true)

		navigationController?.pushViewController(CodeSearchResultViewController(), animated: true)
	}

	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}

	@objc func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			searchHistory.remove(at: indexPath.row)
			tableView.reloadData()
		}
	}
}

//내가 만든 기능
extension CodeSearchViewController {
	@objc func xmarkButtonClicked(sender: UIButton) {
		if searchHistory.count == 1 {
			mainView.emptyImageView.isHidden = false
			mainView.emptyLabel.isHidden = false
			mainView.currentSearchLabel.isHidden = true
			mainView.allDeleteButton.isHidden = true
		}
		searchHistory.remove(at: sender.tag)
		mainView.searchTableView.reloadData()
		view.endEditing(true)
	}

	func configureView() {
		let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
		self.navigationItem.backBarButtonItem = backBarButton
		view.backgroundColor = .sesacBackground
		mainView.searchTableView.delegate = self
		mainView.searchTableView.dataSource = self

		navigationController?.navigationBar.barTintColor = UIColor.sesacBackground
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.sesacText]

		mainView.searchBar.delegate = self
		mainView.searchBar.searchTextField.textColor = .sesacText
		mainView.searchBar.searchBarStyle = .minimal
		mainView.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "브랜드, 상품, 프로필, 태그 등", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray.cgColor])

		mainView.currentSearchLabel.text = " 최근 검색"
		mainView.currentSearchLabel.font = .boldSystemFont(ofSize: 15)
		mainView.currentSearchLabel.textColor = .sesacText
		mainView.currentSearchLabel.textAlignment = .left

		mainView.allDeleteButton.setTitle("모두 지우기", for: .normal)
		mainView.allDeleteButton.setTitleColor(.sesacPoint, for: .normal)
		mainView.allDeleteButton.titleLabel?.font = .boldSystemFont(ofSize: 13)
		mainView.allDeleteButton.titleLabel?.textAlignment = .right

		mainView.emptyImageView.image = .empty
		mainView.emptyLabel.text = "최근 검색어가 없어요"
		mainView.emptyLabel.font = .boldSystemFont(ofSize: 16)
		mainView.emptyLabel.textColor = .sesacText
		mainView.emptyLabel.textAlignment = .center

		if searchHistory == [] {
			mainView.currentSearchLabel.isHidden = true
			mainView.allDeleteButton.isHidden = true
		} else {
			mainView.emptyImageView.isHidden = true
			mainView.emptyLabel.isHidden = true
		}
	}
}

extension CodeSearchViewController {

	static func saveStructUserDefaults() {
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(CodeSearchViewController.wishList) {
			UserDefaults.standard.setValue(encoded, forKey: "Wish")
		}
	}

	static func loadStructUserDefaults() {
		if let savedData = UserDefaults.standard.object(forKey: "Wish") as? Data {
			let decoder = JSONDecoder()
			if let savedWishList = try? decoder.decode([Item].self, from: savedData) {
				CodeSearchViewController.wishList = savedWishList
			}
		}
	}
}



