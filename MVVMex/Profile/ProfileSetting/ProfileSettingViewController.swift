//
//  ProfileSettingViewController.swift
//  MovieLike
//
//  Created by 최정안 on 1/26/25.
//

import UIKit
final class ProfileSettingViewController: UIViewController {

    private let mainView = ProfileSettingView()
    private let viewModel = ProfileSettingViewModel()
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        mainView.nicknameTextField.becomeFirstResponder()
        setAction()
        setNavigationBar()
        bindData()
        mainView.mbtiCollectionView.allowsMultipleSelection = true
    }
    private func setDelegate() {
        mainView.nicknameTextField.delegate = self
        mainView.mbtiCollectionView.delegate = self
        mainView.mbtiCollectionView.dataSource = self
    }
    private func setNavigationBar() {
        navigationItem.setBarTitleView(title: "PROFILE SETTING")
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backToOnboardingView))
        navigationItem.leftBarButtonItem?.tintColor = .ValidButtonColor
        
    }
    private func bindData() {
        viewModel.outputImage.bind { img in
            self.mainView.profileImageButton.setImage(UIImage(named: img), for: .normal)
        }
        viewModel.outputIsButtonEnable.bind { bool in
            self.mainView.finishButton.isEnabled = bool
            self.changeButtonColor(isenabled: bool)
        }
        viewModel.outputDescriptionLabel.bind { text in
            self.mainView.descriptionLabel.text = text
        }
        viewModel.outputInitialImage.lazyBind { img in
            let vc = ProfileImageSettingViewController()
            vc.viewModel.inputPassData.value = { data in
                if let data {
                    self.viewModel.initialImage = data
                    self.mainView.profileImageButton.setImage(UIImage(named: "profile_\(data)"), for: .normal)
                } else {
                    return self.viewModel.initialImage
                }
                return nil
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    private func changeButtonColor(isenabled: Bool) {
        var color = UIColor.white
        if isenabled {
            color = .ValidButtonColor
        } else {
            color = .InvalidButtonColor
        }
        mainView.finishButton.backgroundColor = color
        mainView.finishButton.layer.borderColor = color.cgColor
    }
    @objc func profileImageTapped() {
            viewModel.inputProfileImageTrigger.value = ()
    }
    private func setAction() {
        mainView.finishButton.addTarget(self, action: #selector(finishButtonClicked), for: .touchUpInside)
        mainView.nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        mainView.profileImageButton.addTarget(self, action: #selector(profileImageTapped), for: .touchUpInside)
        
    }
//    @objc func backButtonTapped() {
//        dismiss(animated: true)
//
//    }
//    @objc func backToOnboardingView() {
//        navigationController?.popViewController(animated: true)
//    }

    @objc func finishButtonClicked() {
        viewModel.inputFinishButtonTrigger.value = mainView.nicknameTextField.text!

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        let nav = UINavigationController(rootViewController: MainViewController())
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.updateViewLayout()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        viewModel.outputpreparedNickname.bind { text in
            self.mainView.nicknameTextField.text = text
        }
        
        viewModel.inputNickname.value = mainView.nicknameTextField.text

    }

    
    @objc func textFieldDidChange() {
        viewModel.inputNickname.value = mainView.nicknameTextField.text
    }
    

}
extension ProfileSettingViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
extension ProfileSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MBTICollectionViewCell.id, for: indexPath) as? MBTICollectionViewCell else {return UICollectionViewCell()}
        
        cell.configData(itemidx: indexPath.item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var anotherItemIdx : Int
        if indexPath.item < 4 {
            anotherItemIdx = indexPath.item + 4
        } else {
            anotherItemIdx = indexPath.item - 4
        }
        guard let anotherItem = collectionView.cellForItem(at: IndexPath(row: anotherItemIdx, section: 0)) else {return}
       
        if let cell = collectionView.cellForItem(at: indexPath) as? MBTICollectionViewCell ,
           !anotherItem.isSelected
        {
            cell.changeCellColor(isSelected: true)
            viewModel.inputSelectedCell.value.insert(indexPath.item)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MBTICollectionViewCell
        {
            cell.changeCellColor(isSelected: false)
            viewModel.inputSelectedCell.value.remove(indexPath.item)
        }

    }
    
}
