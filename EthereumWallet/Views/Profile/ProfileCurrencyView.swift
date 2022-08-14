//
//  ProfileCurrencyView.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/14.
//

import SwiftUI

struct ProfileCurrencyCell: View {
    
    var currency: Currency
    
    var currencyType: CurrencyType {
        currency.type
    }
    
    var formatedValue: String {
        if currency.amount < 1 {
            return String(format: "%.4f", currency.amount)
        }
        return String(format: "%.2f", currency.amount)
    }
    
    var body: some View {
        HStack {
            Text(currencyType.rawValue)
                .font(.system(size: 13))
                .bold()
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(.black)
                .background(currencyType.color)
                .cornerRadius(20)
            
            Text(currencyType.name)
            
            Spacer()
            
            Text(formatedValue)
                .font(.body)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct ProfileCurrencyView: View {
    @Binding var ownedCurrencies: [Currency]
    
    @State private var showSellSheet = false
    @State private var sellType: CurrencyType = .USD
    
    var body: some View {
        List(self.ownedCurrencies, id: \.self) { currency in
            ProfileCurrencyCell(currency: currency)
                .onTapGesture {
                    guard currency.type.isDigital else { return }
                    sellType = currency.type
                    showSellSheet.toggle()
                }
        }.sheet(isPresented: $showSellSheet) {
            SellSheetView(sellType: sellType, toType: .USD)
        }
    }
}

//struct ProfileCurrencyView_Previews: PreviewProvider {
//    @EnvironmentObject var user: User = User()
//    static var previews: some View {
//        ProfileCurrencyView(ownedCurrencies: $user.ownedCurrencies)
//    }
//}
