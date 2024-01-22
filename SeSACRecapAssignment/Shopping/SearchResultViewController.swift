//
//  SearchResultViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/21/24.
//

import UIKit
import Alamofire
import Kingfisher

enum ButtonTitle: String {
    case first = " 정확도 "
    case second = " 날짜순 "
    case third = " 가격높은순 "
    case fourth = " 가격낮은순 "

    var sort: String {
        switch self {
        case .first:
            return "sim"
        case .second:
            return "date"
        case .third:
            return "dsc"
        case .fourth:
            return "asc"
        }
    }
}


class SearchResultViewController: UIViewController {

    @IBOutlet var totalLabel: UILabel!

    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    @IBOutlet var fourthButton: UIButton!

    @IBOutlet var searchResultCollectionView: UICollectionView!

    var itemList: Shopping = Shopping(lastBuildDate: "", total: 0, start: 0, display: 0, items: [])
    var itemNumber = 1
    var lastPage = 1
    var currenSelected: ButtonTitle = .first



    override func viewWillAppear(_ animated: Bool) {
        searchResultCollectionView.reloadData()
        print("??")
    }

    override func viewDidLoad() {
        super.viewDidLoad()



        configureView()



        designButton(button: firstButton, title: ButtonTitle.first.rawValue, active: true)
        designButton(button: secondButton, title: ButtonTitle.second.rawValue, active: false)
        designButton(button: thirdButton, title: ButtonTitle.third.rawValue, active: false)
        designButton(button: fourthButton, title: ButtonTitle.fourth.rawValue, active: false)
    }

    @IBAction func firstButtonClicked(_ sender: UIButton) {
        designButton(button: firstButton, title: ButtonTitle.first.rawValue, active: true)
        designButton(button: secondButton, title: ButtonTitle.second.rawValue, active: false)
        designButton(button: thirdButton, title: ButtonTitle.third.rawValue, active: false)
        designButton(button: fourthButton, title: ButtonTitle.fourth.rawValue, active: false)
        itemNumber = 1
        currenSelected = .first
        callRequest(text: UserDefaults.standard.string(forKey: "SearchItem")!, sort: currenSelected.sort)

    }


    @IBAction func secondButtonClicked(_ sender: UIButton) {
        designButton(button: firstButton, title: ButtonTitle.first.rawValue, active: false)
        designButton(button: secondButton, title: ButtonTitle.second.rawValue, active: true)
        designButton(button: thirdButton, title: ButtonTitle.third.rawValue, active: false)
        designButton(button: fourthButton, title: ButtonTitle.fourth.rawValue, active: false)
        itemNumber = 1
        currenSelected = .second
        callRequest(text: UserDefaults.standard.string(forKey: "SearchItem")!, sort: currenSelected.sort)

    }


    @IBAction func thirdButtonClicked(_ sender: UIButton) {
        designButton(button: firstButton, title: ButtonTitle.first.rawValue, active: false)
        designButton(button: secondButton, title: ButtonTitle.second.rawValue, active: false)
        designButton(button: thirdButton, title: ButtonTitle.third.rawValue, active: true)
        designButton(button: fourthButton, title: ButtonTitle.fourth.rawValue, active: false)
        itemNumber = 1
        currenSelected = .third
        callRequest(text: UserDefaults.standard.string(forKey: "SearchItem")!, sort: currenSelected.sort)

    }


    @IBAction func fourthButtonClicked(_ sender: UIButton) {
        designButton(button: firstButton, title: ButtonTitle.first.rawValue, active: false)
        designButton(button: secondButton, title: ButtonTitle.second.rawValue, active: false)
        designButton(button: thirdButton, title: ButtonTitle.third.rawValue, active: false)
        designButton(button: fourthButton, title: ButtonTitle.fourth.rawValue, active: true)
        itemNumber = 1
        currenSelected = .fourth
        callRequest(text: UserDefaults.standard.string(forKey: "SearchItem")!, sort: currenSelected.sort)

    }


    func callRequest(text: String, sort: String) {
        let url = "https://openapi.naver.com/v1/search/shop.json"

        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]


        let parameters: Parameters = [
            "query": text,
            "start": itemNumber,
            "display": "30",
            "sort": sort
        ]

        AF.request(url, method: .get, parameters: parameters, headers: headers).responseDecodable(of: Shopping.self) { response in
            switch response.result {
            case .success(let success):

                if self.itemNumber == 1 {
                    self.itemList = success
                    self.lastPage = success.total / 30

                    print(self.lastPage)
                    dump(self.itemList)
                    self.totalLabel.text = "\(self.intNumberFormatter(number: success.total)) 개의 검색 결과"

                } else {

                    self.itemList.items.append(contentsOf: success.items)
                }

                self.searchResultCollectionView.reloadData()

                if self.itemNumber == 1 {
                    self.searchResultCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)

                }


            case .failure(let failure):
                print(failure)
            }
        }
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return itemList.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = searchResultCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultCollectionViewCell", for: indexPath) as! SearchResultCollectionViewCell
        let url = URL(string: itemList.items[indexPath.row].image)
        cell.backgroundColor = .clear

        cell.itemImageView.kf.setImage(with: url)
        cell.itemImageView.contentMode = .scaleAspectFill
        cell.itemImageView.layer.masksToBounds = true
        cell.itemImageView.layer.cornerRadius = 10

        cell.mallNameLabel.text = itemList.items[indexPath.row].mallName
        cell.mallNameLabel.textColor = .systemGray2
        cell.mallNameLabel.font = .systemFont(ofSize: 13)
        cell.titleLabel.text = itemList.items[indexPath.row].title
        cell.titleLabel.textColor = .systemGray4
        cell.titleLabel.font = .systemFont(ofSize: 13)
        cell.titleLabel.numberOfLines = 2

        cell.lpriceLabel.text = stringNumberFormatter(number: itemList.items[indexPath.row].lprice)
        cell.lpriceLabel.textColor = .sesacText
        cell.lpriceLabel.font = .boldSystemFont(ofSize: 14)

        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        cell.likeButton.backgroundColor = .white
        cell.likeButton.layer.masksToBounds = true
        cell.likeButton.layer.cornerRadius = 16

        let image = itemList.items[indexPath.row].like ?? false ? "heart.fill" : "heart"
        cell.likeButton.setImage(UIImage(systemName: image), for: .normal)
        cell.likeButton.tintColor = .black

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDefaults.standard.setValue(itemList.items[indexPath.row].productId, forKey: "ProductId")
        UserDefaults.standard.setValue(itemList.items[indexPath.row].like, forKey: "Like")
        UserDefaults.standard.setValue(itemList.items[indexPath.row].title, forKey: "Title")

        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductWebViewController") as! ProductWebViewController
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func likeButtonClicked(sender: UIButton) {
        if itemList.items[sender.tag].like == nil {
            itemList.items[sender.tag].like = true
        } else {
            itemList.items[sender.tag].like!.toggle()
        }

        searchResultCollectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
    }
}



//내가 만든 기능
extension SearchResultViewController {
    func configureView() {
        navigationItem.title = "\(UserDefaults.standard.string(forKey: "SearchItem")!)"

        searchResultCollectionView.dataSource = self
        searchResultCollectionView.delegate = self
        searchResultCollectionView.prefetchDataSource = self

        totalLabel.font = .boldSystemFont(ofSize: 13)
        totalLabel.textColor = .sesacPoint

        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3)

        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 2 + 86)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        searchResultCollectionView.backgroundColor = .clear

        searchResultCollectionView.collectionViewLayout = layout


        callRequest(text: UserDefaults.standard.string(forKey: "SearchItem")!, sort: "sim")

    }

    func configureButton(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
    }


    func designButton(button: UIButton, title: String, active: Bool) {

        if active == true {
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
        } else {
            button.backgroundColor = .black
            button.setTitleColor(.white, for: .normal)
        }

        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1

    }



    func intNumberFormatter(number: Int?) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let intPrice = number
        let formattedSave = formatter.string(for: intPrice)!

        return formattedSave
    }

    func stringNumberFormatter(number: String?) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let stringPrice = number
        let intPrice = Int(stringPrice!)
        let formattedSave = formatter.string(for: intPrice)!

        return formattedSave
    }

}


extension SearchResultViewController: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

        for item in indexPaths {
            if itemList.items.count - 6 == item.row {
                itemNumber += 30
                callRequest(text: UserDefaults.standard.string(forKey: "SearchItem")!, sort: currenSelected.sort)


            }
        }
    }


}
