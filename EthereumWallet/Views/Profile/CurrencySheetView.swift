//
//  CurrencySheetView.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/13.
//

import SwiftUI

struct CurrencyCell: View {
    var currencyType: CurrencyType
    
    var body: some View {
        HStack {
            Text(currencyType.rawValue)
                .font(.system(size: 13))
                .bold()
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(.black)
                .background(currencyType.color)
                .cornerRadius(20)
            
            Text(currencyType.name).padding()
        }
    }
}

struct CurrencySheetView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button("Press to dismiss") {
            presentationMode.wrappedValue.dismiss()
        }
        .font(.title)
        .padding()
        
        List {
            ForEach(CurrencyType.allCases) { currencyType in
                if currencyType.isDigital {
                    CurrencyCell(currencyType: currencyType)
                }
            }
        }
        
    }
}

struct CurrencySheetView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySheetView()
    }
}
