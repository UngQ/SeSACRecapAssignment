//
//  SceneDelegate.swift
//  SeSACRecapAssignment
//
//  Created by ungq on 1/18/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        //false라면 사용자가 처음 들어왔을 것이고, 첫 진입 이후에는 True로 바꿔주자.
        let value = UserDefaults.standard.bool(forKey: "UserState")

        if value == false {
            //코드를 통해 앱 시작 화면 설정
            guard let scene = (scene as? UIWindowScene) else { return }

            window = UIWindow(windowScene: scene)

            let sb = UIStoryboard(name: Storyboard.onboarding.rawValue, bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: OnboardingViewController.identifier) as! OnboardingViewController

            let nav = UINavigationController(rootViewController: vc)

            window?.rootViewController = nav

            window?.makeKeyAndVisible()
        } else {
            guard let scene = (scene as? UIWindowScene) else { return }

            window = UIWindow(windowScene: scene)

//            //탭바로 메인 시작하는 방법!!, 탭바 identifier 지정 후 아래 코드
//            let sb = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: Storyboard.mainTabBarController.rawValue) as! UITabBarController
//
//
//            window?.rootViewController = vc


		
			window?.rootViewController = CustomTabBarController()
            window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

