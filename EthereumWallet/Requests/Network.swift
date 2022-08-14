//
//  Network.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/13.
//

import Foundation
import Alamofire
import Realm
import RealmSwift
import SwiftUI

final class Network: ObservableObject {
    private let APIkey = "c414d12b9cc24cce9d1fa88792b3f74b12a98191a20add7faeec04825d5f620a"
    private let singlePriceUrl = "https://min-api.cryptocompare.com/data/price"
    private let multiplePriceUrl = "https://min-api.cryptocompare.com/data/pricemulti"
    private let dailyPairOHLCV = "https://min-api.cryptocompare.com/data/v2/histoday"
    private let dayCount = 7
    
    private var initialCurrencies: [Currency]?
    
    @Published var dayModels: [HistoryDayModel] = [HistoryDayModel](repeating: .init(), count: 7)
    @Published var convertToCurrencyType: CurrencyType = .USD
    @Published var priceBTC: Double = 0
    @Published var allCurrencies: [Currency] = [
        .init(type: .BTC, amount: 0),
        .init(type: .ETH, amount: 0),
        .init(type: .BNB, amount: 0),
        .init(type: .DOT, amount: 0),
        .init(type: .ADA, amount: 0),
        .init(type: .USDT, amount: 0),
        .init(type: .XRP, amount: 0),
        .init(type: .LTC, amount: 0),
        .init(type: .LINK, amount: 0),
        .init(type: .BCH, amount: 0),
    ]
}

extension Network {
    func updateConvertToType() {
        if convertToCurrencyType == .USD {
            convertToCurrencyType = .EUR
        } else if convertToCurrencyType == .EUR {
            convertToCurrencyType = .JPY
        } else if convertToCurrencyType == .JPY {
            convertToCurrencyType = .CNY
        } else if convertToCurrencyType == .CNY {
            convertToCurrencyType = .USD
        }
    }
    
    func resetAllCurrencies() {
        if let initialCurrencies = initialCurrencies {
            allCurrencies = initialCurrencies
        }
    }
    
    func updateAllCurrencies() {
        if initialCurrencies == nil {
            initialCurrencies = allCurrencies
        }
        requestMultiplePricesToSingle(from: CurrencyType.allCases,
                                      to: convertToCurrencyType) { [weak self] multipleModel in
            guard let self = self else { return }
            for type in CurrencyType.allCases {
                if let priceModel = multipleModel.model(of: type),
                   let price = priceModel.price(of: self.convertToCurrencyType) {
                    for i in 0..<self.allCurrencies.count {
                        if self.allCurrencies[i].type == type {
                            self.allCurrencies[i].amount = price
                        }
                    }
                }
            }
        }
    }
    
    func getLastWeekHistory() {
        let params: [String: Any] = [
            "fsym": CurrencyType.BTC.rawValue,
            "tsym": CurrencyType.USD.rawValue,
            "limit": dayCount - 1,
            "api_key": APIkey,
        ]
        AF.request(dailyPairOHLCV, parameters: params)
            .validate()
            .responseDecodable(of: HistoryWeekWrapperModel.self) { [weak self] response in
                guard let model = response.value else { return }
                self?.dayModels = model.weekModel.dayModels
            }
    }
}

private extension Network {
    func requestSinglePriceToSingle(from: CurrencyType, to: CurrencyType, completion: ((Double?) -> Void)? = nil) {
        let params: [String: Any] = [
            "fsym": from.rawValue,
            "tsyms": to.rawValue,
            "api_key": APIkey,
        ]
        AF.request(singlePriceUrl, parameters: params)
            .validate()
            .responseDecodable(of: PriceModel.self) { response in
                guard let model = response.value else { return }
                let price = model.price(of: to)
                completion?(price)
            }
    }
    
    func requestMultiplePricesToSingle(from: [CurrencyType], to: CurrencyType, completion: ((MultiplePriceModel) -> Void)? = nil) {
        let params: [String: Any] = [
            "fsyms": from.map { $0.rawValue }.joined(separator: ","),
            "tsyms": to.rawValue,
            "api_key": APIkey,
        ]
        AF.request(multiplePriceUrl, parameters: params)
            .validate()
            .responseDecodable(of: MultiplePriceModel.self) { response in
                guard let multipleModel = response.value else { return }
                completion?(multipleModel)
            }
    }
}
