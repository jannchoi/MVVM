//
//  CurrencyViewModel.swift
//  MVVMex
//
//  Created by 최정안 on 2/5/25.
//

import Foundation

class CurrencyViewModel {
    
    let inputAmount: Observable<String?> = Observable(nil)
    let outputText = Observable("")
    
    init() {
        inputAmount.bind { value in
            self.convertCurrency()
        }
    }
    
    private func convertCurrency() {
        guard let amountText = inputAmount.value, let amount = Double(amountText) else {
            outputText.value = "올바른 금액을 입력해주세요."
            return
        }
        
        let convertedAmount = amount / 1350.0
        outputText.value = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
        
    }
    
}
