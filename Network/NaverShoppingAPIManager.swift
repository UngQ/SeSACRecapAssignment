//
//  NaverShoppingAPIManager.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/7/24.
//

import Foundation

enum NetworkError: Error {
	case invalidResponse
	case unknown
	case invalidData
}


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

		DispatchQueue.global().async {
			URLSession.shared.dataTask(with: url) { data, response, error in

				guard error == nil else { return }
				guard let data = data else { return }
				guard let response = response as? HTTPURLResponse else { return }

				print(Thread.isMainThread)
				do {
					let result = try JSONDecoder().decode(Shopping.self, from: data)
					DispatchQueue.main.async {
						completionHandler(result)
					}
				} catch {
					return
				}
			}.resume()
		}
	}

	func requestAsyncAwait(text: String, sort: String, itemNumber: Int) async throws -> Shopping {
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

		var url = URLRequest(url: component.url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5)
		url.httpMethod = "GET"
		url.addValue(APIKey.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
		url.addValue(APIKey.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")

		let (data, response) = try await URLSession.shared.data(for: url)

		guard let response = response as? HTTPURLResponse,
			  response.statusCode == 200 else { throw NetworkError.invalidResponse }

		do {
			let result = try JSONDecoder().decode(Shopping.self, from: data)
			return result
		} catch {
			throw NetworkError.invalidData
		}

	}

}
