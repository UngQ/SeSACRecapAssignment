//
//  NaverShopping.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/21/24.
//

import Foundation

struct Shopping: Codable {
  let lastBuildDate: String
  let total: Int
  let start: Int
  let display: Int
  var items: [Item]
}

struct Item: Codable {
  let title: String
  let link: String
  let image: String
  let lprice: String
  let hprice: String
  let mallName: String
  let productId: String
  let productType: String
  let brand: String
  let maker: String
  let category1: String
  let category2: String
  let category3: String
  let category4: String
  var like: Bool?
}


