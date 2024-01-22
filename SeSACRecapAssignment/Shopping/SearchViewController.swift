//
//  SearchViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/21/24.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {

  @IBOutlet var searchBar: UISearchBar!

  @IBOutlet var emptyImageView: UIImageView!
  @IBOutlet var emptyLabel: UILabel!


  @IBOutlet var currentSearchLabel: UILabel!
  @IBOutlet var allDeleteButton: UIButton!
  

  @IBOutlet var searchTableView: UITableView!
  
  var searchHistory = UserDefaults.standard.array(forKey: "SearchHistory") as? [String] ?? []

  override func viewDidLoad() {
    super.viewDidLoad()




    configureView()
    allDeleteButton.addTarget(self, action: #selector(allDeleteButtonClicked), for: .touchUpInside)
    }

  @objc func allDeleteButtonClicked() {
    searchHistory = []
    currentSearchLabel.isHidden = true
    allDeleteButton.isHidden = true
    emptyImageView.isHidden = false
    emptyLabel.isHidden = false

    searchTableView.reloadData()
  }





}








extension SearchViewController: UITabBarDelegate {

}

//서치바 관련
extension SearchViewController: UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if searchBar.text != "" {


      UserDefaults.standard.setValue(searchBar.text, forKey: "SearchItem")

      searchHistory.append(searchBar.searchTextField.text!)
      UserDefaults.standard.setValue(searchHistory, forKey: "SearchHistory")

      searchBar.text = ""

      emptyImageView.isHidden = true
      emptyLabel.isHidden = true

      currentSearchLabel.isHidden = false
      allDeleteButton.isHidden = false

      searchTableView.reloadData()


      let vc = storyboard?.instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController
      navigationController?.pushViewController(vc, animated: true)



    }
  }
}




//테이블뷰 관련
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchHistory.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell

    cell.currentSearchTextLabel.text = searchHistory[indexPath.row]

    return cell


  }
}


//내가 만든 기능
extension SearchViewController {
  func configureView() {

    let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    self.navigationItem.backBarButtonItem = backBarButton


    view.backgroundColor = .sesacBackground
    searchTableView.backgroundColor = .clear
    searchTableView.delegate = self
    searchTableView.dataSource = self

    navigationController?.navigationBar.barTintColor = UIColor.sesacBackground

    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.sesacText]
    navigationItem.title = "\(UserDefaults.standard.string(forKey: "Nickname")!)님의 새싹쇼핑"

    tabBarController?.tabBar.barTintColor = UIColor.sesacBackground
    tabBarController?.tabBar.tintColor = UIColor.sesacText

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
