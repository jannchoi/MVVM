//
//  WordCounterViewModel.swift
//  MVVMex
//
//  Created by 최정안 on 2/5/25.
//

import Foundation

class WordCounterViewModel {
    
    let inputText: Observable<String?> = Observable(nil)
    let outputText = Observable("")
    init() {
        inputText.bind { text in
            self.countText()
        }
    }
    
    func countText() {
        guard let text = inputText.value else {
            outputText.value = "현재까지 0글자 작성중"
            return
        }
        let count = text.count
        outputText.value = "현재까지 \(count)글자 작성중"
    }
}
