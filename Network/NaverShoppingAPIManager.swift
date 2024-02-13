//
//  NaverShoppingAPIManager.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/7/24.
//

import Foundation


class NaverShoppingAPIManager {

	static let shared = NaverShoppingAPIManager()

	private init () {}


	func request(text: String, sort: String, itemNumber: Int, completionHandler: @escaping (Shopping) -> Void) {

		let scheme = "https"
		let host = "openapi.naver.com"
		let path = "/v1/search/shop.json"
		let query = [URLQueryItem(name: "query", value: text),
					 URLQueryItem(name: "start", value: "\(itemNumber)"),
					 URLQueryItem(name: "display", value: "30"),
					 URLQueryItem(name: "sort", value: sort)]

		var component = URLComponents()
		component.scheme = scheme
		component.host = host
		component.path = path
		component.queryItems = query


		var url = URLRequest(url: component.url!)
		url.httpMethod = "GET"
		url.addValue(APIKey.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
		url.addValue(APIKey.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")

		DispatchQueue.main.async {
			URLSession.shared.dataTask(with: url) { data, response, error in
				print(1)
				guard error == nil else { return }
				print(2)
				guard let data = data else { return }
				print(3)
				guard let response = response as? HTTPURLResponse else { return }
				print(4)

				do {
					let result = try JSONDecoder().decode(Shopping.self, from: data)

					completionHandler(result)
				} catch {
					return
				}
			}.resume()
		}


	}

}
