//
//  SellSheetView.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/14.
//

import SwiftUI

struct SellSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var user: User
    @EnvironmentObject var netWork: Network
    
    @State var sellAmount: Double = 0
    @State var isShowingToast: Bool = false
    @State var isFailureToast: Bool = false
    @State var toastMsg: String = ""
    @State var isLeaving: Bool = false
    
    var sellType: CurrencyType
    var toType: CurrencyType
    
    private var userCurrency: Currency {
        for currency in user.ownedCurrencies {
            if currency.type == sellType {
                return currency
            }
        }
        return .init(type: sellType, amount: 0)
    }
    
    private var price: Double {
        for currency in netWork.allCurrencies {
            if currency.type == sellType {
                return currency.amount
            }
        }
        return 0.0
    }
    
    private let width: CGFloat = 180
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Sell \(sellType.name):")
                        .multilineTextAlignment(.leading)
                        .frame(width: width, height: 60, alignment: .leading)
                    
                    Text("\(sellType.name) remaining:")
                        .multilineTextAlignment(.leading)
                        .frame(width: width, height: 60, alignment: .leading)
                }
                
                VStack {
                    TextField("Enter amount to sell", value: $sellAmount, formatter: formatter)
                        .frame(width: nil, height: 60, alignment: .leading)
                        .textFieldStyle(.roundedBorder)
                    
                    Text("\(userCurrency.amount)")
                        .multilineTextAlignment(.leading)
                        .frame(width: width, height: 60, alignment: .leading)
                }
            }.padding()
            
            HStack {
                Button("Sell") {
                    sellBtnClicked()
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
    
    func sellBtnClicked() {
        guard !isLeaving else { return }
        if sellAmount > userCurrency.amount {
            toastMsg = "Not Enough \(userCurrency.type.name) to Sell"
            isFailureToast = true
            isShowingToast = true
            return
        }
        if sellAmount <= 0 {
            toastMsg = "Sell amount invalid!"
            isFailureToast = true
            isShowingToast = true
            return
        }
        
        user.cost(currency: .init(type: sellType, amount: sellAmount))
        user.buy(currency: .init(type: toType, amount: sellAmount * price))
        
        toastMsg = "\(sellType.name) Solded Successfully!"
        isFailureToast = false
        isShowingToast = true
        
        isLeaving = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct SellSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SellSheetView(sellType: .BTC, toType: .USD)
            .environmentObject(User())
            .environmentObject(Network())
    }
}
