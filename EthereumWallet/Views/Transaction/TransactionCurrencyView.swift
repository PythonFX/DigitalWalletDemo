//
//  TransactionCurrencyView.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/14.
//

import SwiftUI

struct TransactionCurrencyCell: View {
    @Binding var currency: Currency
    @Binding var convertToCurrencyType: CurrencyType
    
    var formatedValue: String {
        if currency.amount == 0.0 {
            return "..."
        }
        return String(format: "%.2f", currency.amount)
    }
    
    var body: some View {
        HStack {
            Text(currency.type.rawValue)
                .font(.system(size: 13))
                .bold()
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(.black)
                .background(currency.type.color)
                .cornerRadius(20)
            
            Text(currency.type.name)
                .font(.system(size: 12))
            
            Spacer()
            
            Text("->\(formatedValue)")
                .font(.system(size: 12))
            
            Text(convertToCurrencyType.rawValue)
                .font(.system(size: 10))
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(.black)
                .background(convertToCurrencyType.color)
                .cornerRadius(20)
        }
    }
}

struct TransactionCurrencyView: View {
    @Binding var currencies: [Currency]
    @Binding var convertToCurrencyType: CurrencyType
    
    @State private var showToast = false
    @State private var isToastFailure = true
    @State private var toastMsg = "Please Wait for Network Transmission."
    @State private var showTransactionSheet = false
    @State private var buyType: CurrencyType?

    var body: some View {
        List {
            ForEach(0..<currencies.count) { index in
                if currencies[index].type.isDigital {
                    TransactionCurrencyCell(currency: $currencies[index],
                                            convertToCurrencyType: $convertToCurrencyType)
                    .onTapGesture {
                        if currencies[index].amount == 0.0 {
                            showToast = true
                            return
                        }
                        buyType = currencies[index].type
                        showTransactionSheet.toggle()
                    }
                }
            }
        }.sheet(isPresented: $showTransactionSheet) {
            if let buyType = buyType {
                TransactionSheetView(buyType: buyType, useType: convertToCurrencyType)
            }
        }.toast(isShowing: $showToast, message: $toastMsg, isFailure: $isToastFailure)
    }
}
