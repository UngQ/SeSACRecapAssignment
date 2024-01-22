//
//  UserDefaultManager.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/20/24.
//

import UIKit

//enum ProfileImage: Int, CaseIterable {
//  case profile1 = 1, profile2, profile3, profile4, profile5, profile6, profile7, profile8, profile9, profile10, profile11, profile12, profile13, profile14
//
//}

enum ProfileImage: Int, CaseIterable {
  case profile1 = 1, profile2, profile3, profile4, profile5, profile6, profile7, profile8, profile9, profile10, profile11, profile12, profile13, profile14
}



class UserDefaultManager {

  private init() {} //접근제어, let test = UserDefaultManger() 이런 인스턴스 생성이 불가능해짐, 미리 막아두는것

  //전역에서 사용 위해 타입 프로퍼티 생성
  static let shared = UserDefaultManager()

//  let random33 = ProfileImage.allCases.randomElement()
//
//  let randomImage = UIImage(imageLiteralResourceName: "profile\(random33.raw)")
//
//
//  UserDefaults.standard.setValue(, forKey: <#T##String#>)

  }


  //소스라는 프로퍼티 안에 애플이 설정한
//  var source: String {
//    get {
//      ud.string(forKey: UDKey.source.rawValue) ?? "ko"
//
//    }
//    set {
//      ud.set(newValue, forKey: UDKey.source.rawValue)
//    }
//  }
//
//  var target: String {
//    get {
//      ud.string(forKey: UDKey.target.rawValue) ?? "ko"
//
//    }
//    set {
//      ud.set(newValue, forKey: UDKey.target.rawValue)
//    }
//  }

