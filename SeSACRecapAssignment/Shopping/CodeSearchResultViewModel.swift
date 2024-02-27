//
//  CodeSearchResultViewModel.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/27/24.
//

import Foundation
import Alamofire

class CodeSearchResultViewModel {

	var inputItemText = Observable("")
	var inputSort = Observable("")
	var inputItemNuber = Observable(0)


	func callRequest(text: String, sort: String, itemNumber: Int) {
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


				if success.items.count == 0 {
					self.mainView.totalLabel.text = "검색 결과가 없습니다"

					self.mainView.searchResultCollectionView.reloadData()
				} else {

					if self.itemNumber == 1 {
						self.itemList = success
						self.lastPage = success.total / 30

						self.mainView.totalLabel.text = "\(self.intNumberFormatter(number: success.total)) 개의 검색 결과"

					} else {

						self.itemList.items.append(contentsOf: success.items)
					}

					self.mainView.searchResultCollectionView.reloadData()

					if self.itemNumber == 1 {
						self.mainView.searchResultCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)

					}
				}

			case .failure(let failure):
				print(failure)
			}
		}
	}

}
