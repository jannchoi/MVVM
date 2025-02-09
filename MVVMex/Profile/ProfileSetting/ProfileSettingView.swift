//
//  ProfileSettingView.swift
//  MovieLike
//
//  Created by 최정안 on 1/26/25.
//

import UIKit
import SnapKit

final class ProfileSettingView: BaseView {
    
    let profileImageButton = UIButton()
    let nicknameTextField = UITextField()
    let descriptionLabel = UILabel()
    let finishButton = UIButton()
    let cameraSymbol = UIImageView()
    private let cameraBack = UIView()
    
    let mbtiLabel = UILabel()
    lazy var mbtiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let totWidth = UIScreen.main.bounds.width - 116
        let itemWidth = totWidth - 30
        layout.itemSize = CGSize(width: itemWidth / 4, height: itemWidth / 4)


        return layout
    }
    override func configureHierachy() {
        addSubview(profileImageButton)
        addSubview(nicknameTextField)
        addSubview(descriptionLabel)
        addSubview(finishButton)
        addSubview(cameraBack)
        addSubview(cameraSymbol)
        addSubview(mbtiLabel)
        addSubview(mbtiCollectionView)
    }
    override func configureLayout() {
        profileImageButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.size.equalTo(80)
        }
        cameraSymbol.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(profileImageButton)
            make.size.equalTo(27)
        }
        cameraBack.snp.makeConstraints { make in
            make.center.equalTo(cameraSymbol)
            make.size.equalTo(15)
        }
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
            make.height.equalTo(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(17)
        }
        mbtiLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(50)
            make.leading.equalTo(safeAreaLayoutGuide).offset(8)
            make.height.equalTo(20)
            make.width.equalTo(50)
        }
        mbtiCollectionView.snp.makeConstraints { make in
            make.top.equalTo(mbtiLabel)
            make.bottom.greaterThanOrEqualTo(safeAreaLayoutGuide).inset(100)
            make.leading.equalTo(mbtiLabel.snp.trailing).offset(50)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(8)
        }
        finishButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
            make.height.equalTo(40)
        }
    }
    override func configureView() {
        backgroundColor = .white
        nicknameTextField.borderStyle = .none
        nicknameTextField.placeholder = "닉네임을 입력해주세요 :)"
        descriptionLabel.labelDesign(inputText: "2글자 이상 10글자 미만으로 설정해주세요", size: 12, color: .InvalidLabelColor)
        finishButton.setButtonTitle(title: "완료", color: UIColor.white, size: 16, weight: .bold)
        finishButton.backgroundColor = .InvalidButtonColor
        cameraSymbol.image = UIImage(systemName: "camera.circle.fill")
        cameraSymbol.tintColor = .ValidButtonColor
        cameraBack.backgroundColor = .white
        
        mbtiLabel.labelDesign(inputText: "MBTI", size: 16, weight: .bold)
        
        mbtiCollectionView.register(MBTICollectionViewCell.self, forCellWithReuseIdentifier: MBTICollectionViewCell.id)
        mbtiCollectionView.backgroundColor = .white

    }
    func updateViewLayout() {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: nicknameTextField.frame.size.height - 1, width: nicknameTextField.frame.size.width, height: 1)
        border.borderColor = UIColor.lightGray.cgColor
        border.borderWidth = CGFloat(1.0)
        nicknameTextField.layer.addSublayer(border)
        nicknameTextField.layer.masksToBounds = true
        nicknameTextField.textColor = .black
        
        finishButton.layer.cornerRadius = finishButton.frame.height / 2
        finishButton.clipsToBounds = true
        finishButton.layer.borderWidth = 1
        finishButton.layer.borderColor = UIColor.InvalidButtonColor.cgColor
        
        profileImageButton.layer.cornerRadius = profileImageButton.frame.height / 2
        profileImageButton.clipsToBounds = true
        profileImageButton.layer.borderWidth = 3
        profileImageButton.layer.borderColor = UIColor.ValidButtonColor.cgColor
        
        cameraSymbol.layer.cornerRadius = cameraSymbol.frame.height / 2
        cameraSymbol.clipsToBounds = true
    }


}
