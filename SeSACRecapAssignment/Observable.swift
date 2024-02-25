//
//  Observable.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/26/24.
//

import Foundation

class Observable<T> {

	private var closure: ((T) -> Void)?

	var value: T {
		didSet {
			print("closrue! \(value)")
			closure?(value)
		}
	}

	init(_ value: T) {
		self.value = value
	}

	func bind(_ closure: @escaping (T) -> Void) {
		print(#function)
		closure(value)
		self.closure = closure
	}
}
