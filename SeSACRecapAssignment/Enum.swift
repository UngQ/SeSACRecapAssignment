//
//  UserDefaultsKeyValue.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/30/24.
//

import Foundation

enum Storyboard: String {
	case onboarding = "Onboarding"
	case main = "Main"
	case mainTabBarController
}

enum UserDefaultsKey: String {
    case imageNumber = "ImageNumber"
	case nickname = "Nickname"
	case searchHistory = "SearchHistory"
	case wish = "Wish"
}

enum ProfileImage: String, CaseIterable {
  case profile1, profile2, profile3, profile4, profile5, profile6, profile7, profile8, profile9, profile10, profile11, profile12, profile13, profile14
}
