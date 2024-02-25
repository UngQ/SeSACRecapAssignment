//
//  CodeProfileSettingViewModel.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/26/24.
//

import Foundation

class CodeProfileSettingViewModel {

	var inputNickname = Observable("")

	var outputValidation = Observable("")
	var outputValidStatus = Observable(false)

	init() {

		inputNickname.bind { value in
			print("nickname validation")
			self.validation(nickname: value)
		}
	}

	private func validation(nickname: String) {
		outputValidStatus.value = false
		guard nickname.count >= 2 &&
				nickname.count < 10
		else {
			outputValidation.value = ValidationError.limitCharacter.caution
			return
		}
		guard !nickname.contains("@") &&
				!nickname.contains("#") &&
				!nickname.contains("$") &&
				!nickname.contains("%") == true
		else {
			outputValidation.value = ValidationError.restrictSymbol.caution
			return
		}
		guard nickname.rangeOfCharacter(from: .decimalDigits) == nil
		else {
			outputValidation.value = ValidationError.restrictInt.caution
			return
		}
		outputValidation.value = "사용할 수 있는 닉네임이에요"
		outputValidStatus.value = true
	}
}
