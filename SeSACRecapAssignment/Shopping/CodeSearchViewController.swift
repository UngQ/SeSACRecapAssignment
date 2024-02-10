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

	let searchBar = UISearchBar()

	let emptyImageView = UIImageView()
	let emptyLabel = UILabel()

	var currentSearchLabel = UILabel()

	var allDeleteButton = UIButton()

	var searchTableView = UITableView()

	static var searchItem = ""
	static var wishList: [Item] = []
	var searchHistory = UserDefaults.standard.array(forKey: "SearchHistory") as? [String] ?? []

	override func viewDidLoad() {
		super.viewDidLoad()

		view.addSubview(searchBar)
		view.addSubview(emptyImageView)
		view.addSubview(emptyLabel)
		view.addSubview(currentSearchLabel)
		view.addSubview(allDeleteButton)
		view.addSubview(searchTableView)

		CodeSearchViewController.loadStructUserDefaults()

		searchTableView.backgroundColor = .clear
		searchTableView.separatorStyle = .singleLine
		searchTableView.separatorColor = .white





		configureView()
		searchTableView.register(CodeSearchTableViewCell.self, forCellReuseIdentifier: "CodeSearchTableViewCell")


		allDeleteButton.addTarget(self, action: #selector(allDeleteButtonClicked), for: .touchUpInside)

		searchBar.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.leading.equalTo(4)
			make.trailing.equalTo(-4)
		}

		emptyImageView.snp.makeConstraints { make in
			make.centerX.centerY.equalToSuperview()
		}

		emptyLabel.snp.makeConstraints { make in
			make.top.equalTo(emptyImageView.snp.bottom).offset(8)
		}

		currentSearchLabel.snp.makeConstraints { make in
			make.top.equalTo(searchBar.snp.bottom).offset(8)
			make.leading.equalTo(4)

		}

		allDeleteButton.snp.makeConstraints { make in
			make.top.equalTo(searchBar.snp.bottom).offset(8)
			make.trailing.equalTo(-4)
		}

		searchTableView.snp.makeConstraints { make in
			make.top.equalTo(currentSearchLabel.snp.bottom).offset(4)
			make.trailing.equalTo(0)
			make.leading.equalTo(0)
			make.bottom.equalToSuperview()
		}

	}



	override func viewWillAppear(_ animated: Bool) {

		navigationItem.title = "\(UserDefaults.standard.string(forKey: "Nickname")!)님의 새싹쇼핑"

		searchTableView.reloadData()



	}



	@objc func allDeleteButtonClicked() {

		searchHistory = []

		currentSearchLabel.isHidden = true

		allDeleteButton.isHidden = true

		emptyImageView.isHidden = false

		emptyLabel.isHidden = false

		view.endEditing(true)



		searchTableView.reloadData()

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

			emptyImageView.isHidden = true
			emptyLabel.isHidden = true
			currentSearchLabel.isHidden = false
			allDeleteButton.isHidden = false

			searchTableView.reloadData()
			print(searchHistory)

			let sb = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil)

			let vc = sb.instantiateViewController(withIdentifier: SearchResultViewController.identifier) as! SearchResultViewController

			navigationController?.pushViewController(vc, animated: true)

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

		let cell = searchTableView.dequeueReusableCell(withIdentifier: CodeSearchTableViewCell.identifier, for: indexPath) as! CodeSearchTableViewCell


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


		let sb = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil)

		let vc = sb.instantiateViewController(withIdentifier: SearchResultViewController.identifier) as! SearchResultViewController

		navigationController?.pushViewController(vc, animated: true)

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

			emptyImageView.isHidden = false

			emptyLabel.isHidden = false

			currentSearchLabel.isHidden = true

			allDeleteButton.isHidden = true

		}

		searchHistory.remove(at: sender.tag)

		searchTableView.reloadData()

		view.endEditing(true)

	}



	func configureView() {



		let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

		self.navigationItem.backBarButtonItem = backBarButton





		view.backgroundColor = .sesacBackground


		searchTableView.delegate = self

		searchTableView.dataSource = self



		navigationController?.navigationBar.barTintColor = UIColor.sesacBackground



		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.sesacText]



		searchBar.delegate = self



		searchBar.searchTextField.textColor = .sesacText

		searchBar.searchBarStyle = .minimal

		searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "브랜드, 상품, 프로필, 태그 등", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray.cgColor])



		currentSearchLabel.text = " 최근 검색"

		currentSearchLabel.font = .boldSystemFont(ofSize: 15)

		currentSearchLabel.textColor = .sesacText

		currentSearchLabel.textAlignment = .left



		allDeleteButton.setTitle("모두 지우기", for: .normal)

		allDeleteButton.setTitleColor(.sesacPoint, for: .normal)

		allDeleteButton.titleLabel?.font = .boldSystemFont(ofSize: 13)

		allDeleteButton.titleLabel?.textAlignment = .right



		emptyImageView.image = .empty

		emptyLabel.text = "최근 검색어가 없어요"

		emptyLabel.font = .boldSystemFont(ofSize: 16)

		emptyLabel.textColor = .sesacText







		if searchHistory == [] {

			currentSearchLabel.isHidden = true

			allDeleteButton.isHidden = true

		} else {

			emptyImageView.isHidden = true

			emptyLabel.isHidden = true





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

				// return savedWishList

			}

		}

		// return []

	}



}



