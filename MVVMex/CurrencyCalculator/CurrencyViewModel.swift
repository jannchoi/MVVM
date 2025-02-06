//
//  CurrencyViewModel.swift
//  MVVMex
//
//  Created by 최정안 on 2/5/25.
//

import Foundation

class CurrencyViewModel {
    
    let inputRateTrigger: Observable<Void?> = Observable(nil)
    
    let inputAmount: Observable<String?> = Observable(nil)
    let outputText = Observable("")

    var currentRateText: Observable<String?> = Observable(nil)
    private var currentRate: Double? = nil
    
    
    init() {
        inputRateTrigger.bind { _ in
            self.currentRate = self.getRate()
            self.setCurrentLabel()
        }
        //inputAmount가 변할 때마다 계산
        inputAmount.bind { value in
            self.convertCurrency()
        }

    }
    
    private func getRate() -> Double {
        //rate를 가져옴
        return 1350.0
    }
    private func setCurrentLabel() {
        guard let currentValue = currentRate else {
            return
        }
        let formattedRate = currentValue.formatted()
        currentRateText.value = "현재 환율: 1 USD = \(formattedRate)"
    }
    
    private func convertCurrency() {
        guard let amountText = inputAmount.value, let amount = Double(amountText), let currentValue = currentRate else {
            outputText.value = "올바른 금액을 입력해주세요."
            return
        }
        let convertedAmount = amount / currentValue
        outputText.value = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
        
    }
    
}
