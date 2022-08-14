//
//  User.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/14.
//

import Foundation

struct Currency: Identifiable, Hashable {
    var id: String { self.type.rawValue }
    var type: CurrencyType
    var amount: Double
}

class User: ObservableObject {
    @Published var name: String = "New User"
    @Published var ownedCurrencies: [Currency] = [
        .init(type: .USD, amount: 100000),
        .init(type: .CNY, amount: 1000000)
    ]
}

extension User {
    func buy(currency: Currency) {
        for idx in 0..<ownedCurrencies.count {
            if ownedCurrencies[idx].type == currency.type {
                ownedCurrencies[idx].amount += currency.amount
                return
            }
        }
        var old = ownedCurrencies
        old.append(currency)
        ownedCurrencies = old
    }
    
    func cost(currency: Currency) {
        for idx in 0..<ownedCurrencies.count {
            if ownedCurrencies[idx].type == currency.type {
                ownedCurrencies[idx].amount -= currency.amount
                if ownedCurrencies[idx].type.isDigital && ownedCurrencies[idx].amount == 0 {
                    ownedCurrencies.remove(at: idx)
                }
                return
            }
        }
        assertionFailure("Cannot cost currency that you lack.")
    }
}
