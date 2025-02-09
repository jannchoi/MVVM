//
//  ProfileImageSettingViewModel.swift
//  MVVMex
//
//  Created by 최정안 on 2/9/25.
//

import Foundation
final class ProfileImageSettingViewModel {
    
    var inputSettingImageTrigger: Observable<Void?> = Observable(nil)
    var inputPassData: Observable<((Int?) -> (Int?))?> = Observable(nil)
    var inputDidSelectedItemIndex: Observable<Int?> = Observable(nil)
    var selectedItem: Observable<Int?> = Observable(nil)
    
    init() {
        print("ProfileImageSettingViewModel init")
        inputSettingImageTrigger.bind { _ in
            self.setInitialImage()
        }
        inputDidSelectedItemIndex.bind { idx in
            self.updateSelectedItem(idx: idx)
        }
    }
    
    private func setInitialImage() {
        selectedItem.value = inputPassData.value?(nil)
    }
    private func updateSelectedItem(idx: Int?) {
        selectedItem.value = idx
    }
}
