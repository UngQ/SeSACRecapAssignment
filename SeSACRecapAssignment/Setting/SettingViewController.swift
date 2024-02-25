//
//  SettingViewController.swift
//  SeSACRecapAssignment
//
//  Created by ungQ on 1/22/24.
//

import UIKit

enum SettingOptions: String, CaseIterable {
    case notice = "공지사항"
    case qna = "자주 묻는 질문"
    case help = "1:1 문의"
    case alarm = "알림 설정"
    case reset = "처음부터 시작하기"
}

enum AlertText: String {
    case title = "처음부터 시작하기"
    case message = "데이터를 모두 초기화하시겠습니까?"
    case ok = "확인"
    case cancel = "취소"
}

class SettingViewController: UIViewController {

    @IBOutlet var settingTableView: UITableView!

    let list = SettingOptions.allCases
	var count = CodeSearchViewController.wishList.count

    override func viewDidLoad() {
        super.viewDidLoad()

		navigationItem.title = "설정"


        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        view.backgroundColor = .sesacBackground
        settingTableView.backgroundColor = .sesacBackground
        settingTableView.separatorStyle = .singleLine
        settingTableView.separatorColor = .lightGray

        settingTableView.dataSource = self
        settingTableView.delegate = self

        let xib = UINib(nibName: PersonalInformationTableViewCell.identifier, bundle: nil)
        settingTableView.register(xib, forCellReuseIdentifier: PersonalInformationTableViewCell.identifier)

        let xib2 = UINib(nibName: SettingTableViewCell.identifier, bundle: nil)
        settingTableView.register(xib2, forCellReuseIdentifier: SettingTableViewCell.identifier)




    }

    override func viewWillAppear(_ animated: Bool) {

        settingTableView.reloadData()
    }



    func showAlert() {
        let alert = UIAlertController(title: AlertText.title
            .rawValue, message: AlertText.message.rawValue, preferredStyle: .alert)
        let ok = UIAlertAction(title: AlertText.ok.rawValue, style: .default) { response in
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate

 
			//임시
            let vc = CodeOnboardingViewController()
            let nav = UINavigationController(rootViewController: vc)
            UserDefaults.standard.setValue(false, forKey: "UserState")

            sceneDelegate?.window?.rootViewController = nav
            sceneDelegate?.window?.makeKeyAndVisible()
        }
        let cancel = UIAlertAction(title: AlertText.cancel.rawValue, style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }

    @objc func profileImageButtonClicked() {
            navigationController?.pushViewController(CodeProfileImageSettingViewController(), animated: true)
        }
    }


//테이블뷰 관련
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return list.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonalInformationTableViewCell.identifier, for: indexPath) as! PersonalInformationTableViewCell
            cell.profileImageButton.setImage(UIImage(imageLiteralResourceName: "profile\(UserDefaults.standard.integer(forKey: "ImageNumber")+1)"), for: .normal)
            cell.nicknameLabel.text = UserDefaults.standard.string(forKey: "Nickname")
            cell.profileImageButton.addTarget(self, action: #selector(profileImageButtonClicked), for: .touchUpInside)
            cell.likeLabel.text = "\(CodeSearchViewController.wishList.count)개의 상품"

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell

            cell.titleLabel.font = .boldSystemFont(ofSize: 14)
            cell.titleLabel.text = list[indexPath.row].rawValue
            cell.titleLabel.textColor = .sesacText

            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 96
        } else {
            return 48
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {

                navigationController?.pushViewController(CodeProfileSettingViewController(), animated: true)
        }

        if indexPath.section == 1 && indexPath.row == list.endIndex - 1 {
            showAlert()
        }
    }


}
