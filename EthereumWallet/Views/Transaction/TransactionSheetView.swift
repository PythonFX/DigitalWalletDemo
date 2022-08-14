//
//  TransactionSheetView.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/14.
//

import SwiftUI

struct TransactionSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var user: User
    @EnvironmentObject var netWork: Network
    
    @State var buyAmount: Double = 0
    @State var isShowingToast: Bool = false
    @State var isFailureToast: Bool = false
    @State var toastMsg: String = ""
    @State var isLeaving: Bool = false
    
    var buyType: CurrencyType
    var useType: CurrencyType
    
    private let width: CGFloat = 180
    
    private var price: Double {
        for currency in netWork.allCurrencies {
            if currency.type == buyType {
                return currency.amount
            }
        }
        return 0.0
    }
    
    private var userCurrency: Currency {
        for currency in user.ownedCurrencies {
            if currency.type == useType {
                return currency
            }
        }
        return .init(type: useType, amount: 0)
    }
    
    private var remaining: Double {
        return userCurrency.amount - buyAmount * price
    }
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Buy \(buyType.name):")
                        .multilineTextAlignment(.leading)
                        .frame(width: width, height: 60, alignment: .leading)
                    Text("Total \(userCurrency.type.name):")
                        .frame(width: width, height: 60, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    Text("Cost \(userCurrency.type.name):")
                        .multilineTextAlignment(.leading)
                        .frame(width: width, height: 60, alignment: .leading)
                    Text("Remaining \(userCurrency.type.name):")
                        .multilineTextAlignment(.leading)
                        .frame(width: width, height: 60, alignment: .leading)
                }
                
                VStack {
                    TextField("Enter amount to buy", value: $buyAmount, formatter: formatter)
                        .frame(width: nil, height: 60, alignment: .leading)
                        .textFieldStyle(.roundedBorder)
                            
                    Text(String(format: "%.2f", userCurrency.amount))
                        .frame(width: nil, height: 60, alignment: .leading)
                    Text(String(format: "%.2f", buyAmount * price))
                        .frame(width: nil, height: 60, alignment: .leading)
                    Text(String(format: "%.2f", remaining))
                        .frame(width: nil, height: 60, alignment: .leading)
                }
            }.padding()
            
            HStack {
                Button("Buy") {
                    confirmBtnClicked()
                }
                .padding(.init(top: 6, leading: 10, bottom: 6, trailing: 10))
                .foregroundColor(Color.white)
                .background(Color.blue)
                .font(.title3)
                .cornerRadius(6)
                .padding()
                
                Button("Back") {
                    guard !isLeaving else { return }
                    presentationMode.wrappedValue.dismiss()
                }
                .padding(.init(top: 6, leading: 10, bottom: 6, trailing: 10))
                .foregroundColor(Color.white)
                .background(Color.blue)
                .font(.title3)
                .cornerRadius(6)
                .padding()
            }
            .padding()
        }
        .onAppear { netWork.updateAllCurrencies() }
        .toast(isShowing: $isShowingToast, message: $toastMsg, isFailure: $isFailureToast)
    }
    
    func confirmBtnClicked() {
        guard !isLeaving else { return }
        if remaining < 0 {
            toastMsg = "Not Enough money"
            isFailureToast = true
            isShowingToast = true
            return
        }
        if buyAmount <= 0 {
            toastMsg = "Purchase amount invalid!"
            isFailureToast = true
            isShowingToast = true
            return
        }
        
        user.cost(currency: .init(type: useType, amount: buyAmount * price))
        user.buy(currency: .init(type: buyType, amount: buyAmount))
        
        toastMsg = "\(buyType.name) Purchased Successfully!"
        isFailureToast = false
        isShowingToast = true
        
        isLeaving = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct TransactionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionSheetView(buyType: .BTC, useType: .USD).environmentObject(User())
    }
}
