//
//  ProfileImageSettingViewController.swift
//  MovieLike
//
//  Created by 최정안 on 1/26/25.
//

import UIKit

final class ProfileImageSettingViewController: BaseViewController {

    
    private let mainView = ProfileImageSettingView()
    let viewModel = ProfileImageSettingViewModel()

    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        setDelegate()
        viewModel.inputSettingImageTrigger.value = ()
        bindData()
    }
    private func bindData() {
        viewModel.selectedItem.bind { num in
            guard let num else {return}
            self.mainView.selectedImage.image = UIImage(named: "profile_\(num)")
        }
    }
    private func setNavigationBar() {
        navigationItem.setBarTitleView(title: "PROFILE SETTING")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backToProfileSetting))
        navigationItem.leftBarButtonItem?.tintColor = .ValidButtonColor
    }
    private func setDelegate() {
        mainView.profileImages.delegate = self
        mainView.profileImages.dataSource = self
    }
    @objc func backToProfileSetting() {
        viewModel.inputPassData.value?(viewModel.selectedItem.value)
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.updateViewLayout()
    }


}

extension ProfileImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as? ProfileImageCollectionViewCell else {return UICollectionViewCell()}
        
        cell.configImage(itemidx: indexPath.item, selected: viewModel.selectedItem.value!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.inputDidSelectedItemIndex.value = indexPath.item
        collectionView.reloadData()
    }
    
}
