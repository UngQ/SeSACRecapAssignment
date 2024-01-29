////
////  SearchViewController.swift
////  SeSACRecapAssignment
////
////  Created by ungQ on 1/21/24.
////
//
//import UIKit
//import Alamofire
//import Toast
//
//
//class SearchViewController: UIViewController {
//
//	@IBOutlet var searchBar: UISearchBar!
//
//	@IBOutlet var emptyImageView: UIImageView!
//	@IBOutlet var emptyLabel: UILabel!
//
//	@IBOutlet var currentSearchLabel: UILabel!
//	@IBOutlet var allDeleteButton: UIButton!
//
//	@IBOutlet var searchTableView: UITableView!
//
//	static var searchItem = ""
//	static var wishList: [Item] = []
//	
//	var searchHistory = UserDefaults.standard.array(forKey: "SearchHistory") as? [String] ?? []
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		SearchViewController.loadStructUserDefaults()
//
//		configureView()
//
//		allDeleteButton.addTarget(self, action: #selector(allDeleteButtonClicked), for: .touchUpInside)
//	}
//
//	override func viewWillAppear(_ animated: Bool) {
//		navigationItem.title = "\(UserDefaults.standard.string(forKey: "Nickname")!)님의 새싹쇼핑"
//		searchTableView.reloadData()
//
//	}
//
//	@objc func allDeleteButtonClicked() {
//		searchHistory = []
//		currentSearchLabel.isHidden = true
//		allDeleteButton.isHidden = true
//		emptyImageView.isHidden = false
//		emptyLabel.isHidden = false
//		view.endEditing(true)
//
//		searchTableView.reloadData()
//	}
//}
//
//
//
//
//
//
//
//
//extension SearchViewController: UITabBarDelegate {
//
//}
//
////서치바 관련
//extension SearchViewController: UISearchBarDelegate {
//
//	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//		view.endEditing(true)
//		if searchBar.text != "" {
//
//
//			SearchViewController.searchItem = searchBar.searchTextField.text!
//
//			searchHistory.insert(searchBar.searchTextField.text!, at: 0)
//
//			UserDefaults.standard.setValue(searchHistory, forKey: "SearchHistory")
//
//			searchBar.text = ""
//
//			emptyImageView.isHidden = true
//			emptyLabel.isHidden = true
//
//			currentSearchLabel.isHidden = false
//			allDeleteButton.isHidden = false
//
//			searchTableView.reloadData()
//			print(SearchViewController.searchItem)
//
//
//			let vc = storyboard?.instantiateViewController(withIdentifier: SearchResultViewController.identifier) as! SearchResultViewController
//			navigationController?.pushViewController(vc, animated: true)
//
//		} else {
//			self.view.makeToast("검색어를 입력하세요!", position: .center)
//		}
//	}
//}
//
//
//
//
////테이블뷰 관련
//extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return searchHistory.count
//	}
//
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		let cell = searchTableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
//
//		//수정
//		cell.currentSearchTextLabel.text = searchHistory[indexPath.row]
//
//		cell.xmarkButton.tag = indexPath.row
//
//		cell.xmarkButton.addTarget(self, action: #selector(xmarkButtonClicked), for: .touchUpInside)
//
//
//		return cell
//	}
//
//
//
//	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//		64
//	}
//
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//		SearchViewController.searchItem = searchHistory[indexPath.row]
//		searchHistory.remove(at: indexPath.row)
//		searchHistory.insert(SearchViewController.searchItem, at: 0)
//		print(SearchViewController.searchItem)
//
//		tableView.reloadData()
//		view.endEditing(true)
//
//		let vc = storyboard?.instantiateViewController(withIdentifier: SearchResultViewController.identifier) as! SearchResultViewController
//		navigationController?.pushViewController(vc, animated: true)
//	}
//
//
//	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//		return true
//	}
//
//	@objc func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//		if editingStyle == .delete {
//			searchHistory.remove(at: indexPath.row)
//			tableView.reloadData()
//		}
//	}
//}
//
//
////내가 만든 기능
//extension SearchViewController {
//	@objc func xmarkButtonClicked(sender: UIButton) {
//		if searchHistory.count == 1 {
//			emptyImageView.isHidden = false
//			emptyLabel.isHidden = false
//			currentSearchLabel.isHidden = true
//			allDeleteButton.isHidden = true
//		}
//		searchHistory.remove(at: sender.tag)
//		searchTableView.reloadData()
//		view.endEditing(true)
//	}
//
//	func configureView() {
//
//		let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//		self.navigationItem.backBarButtonItem = backBarButton
//
//
//		view.backgroundColor = .sesacBackground
//		searchTableView.backgroundColor = .clear
//		searchTableView.delegate = self
//		searchTableView.dataSource = self
//
//		navigationController?.navigationBar.barTintColor = UIColor.sesacBackground
//
//		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.sesacText]
//
//		tabBarController?.tabBar.barTintColor = UIColor.sesacBackground
//		tabBarController?.tabBar.tintColor = UIColor.sesacText
//
//		searchBar.delegate = self
//
//		searchBar.searchTextField.textColor = .sesacText
//		searchBar.searchBarStyle = .minimal
//		searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "브랜드, 상품, 프로필, 태그 등", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray.cgColor])
//
//		currentSearchLabel.text = " 최근 검색"
//		currentSearchLabel.font = .boldSystemFont(ofSize: 15)
//		currentSearchLabel.textColor = .sesacText
//		currentSearchLabel.textAlignment = .left
//
//		allDeleteButton.setTitle("모두 지우기", for: .normal)
//		allDeleteButton.setTitleColor(.sesacPoint, for: .normal)
//		allDeleteButton.titleLabel?.font = .boldSystemFont(ofSize: 13)
//		allDeleteButton.titleLabel?.textAlignment = .right
//
//		emptyImageView.image = .empty
//		emptyLabel.text = "최근 검색어가 없어요"
//		emptyLabel.font = .boldSystemFont(ofSize: 16)
//		emptyLabel.textColor = .sesacText
//
//
//
//		if searchHistory == [] {
//			currentSearchLabel.isHidden = true
//			allDeleteButton.isHidden = true
//		} else {
//			emptyImageView.isHidden = true
//			emptyLabel.isHidden = true
//
//
//		}
//
//	}
//}
//
//
//extension SearchViewController {
//	static func saveStructUserDefaults() {
//		let encoder = JSONEncoder()
//		if let encoded = try? encoder.encode(SearchViewController.wishList) {
//			UserDefaults.standard.setValue(encoded, forKey: "Wish")
//		}
//	}
//
//	static func loadStructUserDefaults() {
//		if let savedData = UserDefaults.standard.object(forKey: "Wish") as? Data {
//			let decoder = JSONDecoder()
//			if let savedWishList = try? decoder.decode([Item].self, from: savedData) {
//				SearchViewController.wishList = savedWishList
////				return savedWishList
//			}
//		}
////		return []
//	}
//
//}
