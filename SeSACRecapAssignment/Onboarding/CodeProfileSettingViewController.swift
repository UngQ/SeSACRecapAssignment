//
//  CodeProfileSettingViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 2/10/24.
//

import UIKit

class CodeProfileSettingViewController: UIViewController {


	let mainView = CodeProfileSettingView()


	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}