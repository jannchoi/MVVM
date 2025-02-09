//
//  ProfileSettingViewModel.swift
//  MVVMex
//
//  Created by 최정안 on 2/9/25.
//

import Foundation

final class ProfileSettingViewModel {
    
    var initialImage = Int.random(in: 0...11)
    //input
    var inputNickname: Observable<String?> = Observable(nil)
    var inputFinishButtonTrigger: Observable<String?> = Observable("")
    var inputProfileImageTrigger: Observable<Void?> = Observable(nil)
    var inputSelectedCell: Observable<Set<Int>> = Observable([])
    

    //output
    var outputImage: Observable<String> = Observable("")
    var outputDescriptionLabel: Observable<String> = Observable("")
    var outputpreparedNickname: Observable<String> = Observable("")
    var outputInitialImage: Observable<Void> = Observable(())
    var outputIsButtonEnable: Observable<Bool> = Observable(false)
    
    private var nicknameIsValid: Observable<Bool> = Observable(false)
    private var mbtiIsValid: Observable<Bool> = Observable(false)
    init() {
        print("ProfileSettingViewModel init")
        self.setProfileImage()
        
        self.inputNickname.bind { _ in
            self.isValidNickname()
            self.checkIsButtonEnable()
        }
        self.inputFinishButtonTrigger.bind { _ in
            self.saveData()
        }
        self.inputProfileImageTrigger.bind { _ in
            self.passImageData()
        }
        self.inputSelectedCell.bind { _ in
            self.checkMbtiIsValid()
            self.checkIsButtonEnable()
        }

    }
    private func checkIsButtonEnable() {
        outputIsButtonEnable.value = nicknameIsValid.value && mbtiIsValid.value
    }
    private func checkMbtiIsValid() {
        if inputSelectedCell.value.count == 4 {
            mbtiIsValid.value = true
        } else {
            mbtiIsValid.value = false
        }
    }
    private func passImageData() {
        outputInitialImage.value = ()
    }
    private func prepareNickname() {
        if UserDefaultsManager.shared.nickname != "" {
            outputpreparedNickname.value = UserDefaultsManager.shared.nickname
        }
    }
    private func saveData() {
        guard let nickname = inputFinishButtonTrigger.value
        else {return}
        UserDefaultsManager.shared.nickname = nickname
        UserDefaultsManager.shared.profileImage = initialImage
        UserDefaultsManager.shared.used = true
        
    }
    
    
    private func isValidNickname() {
        guard let input = inputNickname.value else {return}
        let trimmedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        var description : String
        if trimmedInput.count < 2 || trimmedInput.count >= 10 {
            description = "2글자 이상 10글자 미만으로 설정해 주세요."
            nicknameIsValid.value = false
        } else if trimmedInput.contains(where: {"@#$%".contains($0)}) {
            description = "닉네임에 @,#,$,%는 포함할 수 없어요."
            nicknameIsValid.value = false
        } else if trimmedInput.contains(where: {"1234567890".contains($0)}) {
            description = "닉네임에 숫자는 포함할 수 없어요."
            nicknameIsValid.value = false
        } else {
            description = "사용할 수 있는 닉네임이에요."
            nicknameIsValid.value = true
        }
        outputDescriptionLabel.value = description
    }

    
    private func setProfileImage() {
        let userdefaults = UserDefaultsManager.shared
        
        if initialImage != userdefaults.profileImage && userdefaults.profileImage != 0 {
            outputImage.value = "profile_\(initialImage)"
        } else {
            initialImage = userdefaults.profileImage
            outputImage.value = "profile_\(initialImage)"
        }
        
    }
    
}
