//
//  CustomTabBarController.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/29/24.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()


		self.tabBar.tintColor = .sesacPoint
		self.tabBar.barTintColor = .sesacBackground
		self.tabBar.isTranslucent = false
		self.tabBar.unselectedItemTintColor = .white



		let firstVC = UINavigationController(rootViewController: CodeSearchViewController())

		firstVC.tabBarItem.title = "검색"
		firstVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")

		let secondSB = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil)
		let secondVC = secondSB.instantiateViewController(withIdentifier: WishListViewController.identifier) as! WishListViewController
		let secondNav = UINavigationController(rootViewController: secondVC)

		secondNav.tabBarItem.title = "위시"
		secondNav.tabBarItem.image = UIImage(systemName: "heart")


		let thirdSB = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil)
		let thirdVC = thirdSB.instantiateViewController(withIdentifier: SettingViewController.identifier) as! SettingViewController
		let thirdNav = UINavigationController(rootViewController: thirdVC)

		thirdNav.tabBarItem.title = "설정"
		thirdNav.tabBarItem.image = UIImage(systemName: "person")



//		let vc = UINavigationController(rootViewController: firstVC)


		viewControllers = [firstVC, secondNav, thirdNav]
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
