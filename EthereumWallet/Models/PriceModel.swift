//
//  PriceModel.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/14.
//

import Foundation

struct MultiplePriceModel: Decodable {
    var BTC: PriceModel?
    var ETH: PriceModel?
    var BNB: PriceModel?
    var DOT: PriceModel?
    var ADA: PriceModel?
    var USDT: PriceModel?
    var XRP: PriceModel?
    var LTC: PriceModel?
    var LINK: PriceModel?
    var BCH: PriceModel?
    var USD: PriceModel?
    var EUR: PriceModel?
    var JPY: PriceModel?
    var CNY: PriceModel?
    
    enum CodingKeys: String, CodingKey {
        case BTC
        case ETH
        case BNB
        case DOT
        case ADA
        case USDT
        case XRP
        case LTC
        case LINK
        case BCH
        case USD
        case EUR
        case JPY
        case CNY
    }
    
    func model(of type: CurrencyType) -> PriceModel? {
        switch type {
        case .BTC:
            return self.BTC
        case .ETH:
            return self.ETH
        case .BNB:
            return self.BNB
        case .DOT:
            return self.DOT
        case .ADA:
            return self.ADA
        case .USDT:
            return self.USDT
        case .XRP:
            return self.XRP
        case .LTC:
            return self.LTC
        case .LINK:
            return self.LINK
        case .BCH:
            return self.BCH
        case .USD:
            return self.USD
        case .EUR:
            return self.EUR
        case .JPY:
            return self.JPY
        case .CNY:
            return self.CNY
        }
    }
}

struct PriceModel: Decodable {
    var BTC: Double?
    var ETH: Double?
    var BNB: Double?
    var DOT: Double?
    var ADA: Double?
    var USDT: Double?
    var XRP: Double?
    var LTC: Double?
    var LINK: Double?
    var BCH: Double?
    var USD: Double?
    var EUR: Double?
    var JPY: Double?
    var CNY: Double?
    
    enum CodingKeys: String, CodingKey {
        case BTC
        case ETH
        case BNB
        case DOT
        case ADA
        case USDT
        case XRP
        case LTC
        case LINK
        case BCH
        case USD
        case EUR
        case JPY
        case CNY
    }
    
    func price(of type: CurrencyType) -> Double? {
        switch type {
        case .BTC:
            return self.BTC
        case .ETH:
            return self.ETH
        case .BNB:
            return self.BNB
        case .DOT:
            return self.DOT
        case .ADA:
            return self.ADA
        case .USDT:
            return self.USDT
        case .XRP:
            return self.XRP
        case .LTC:
            return self.LTC
        case .LINK:
            return self.LINK
        case .BCH:
            return self.BCH
        case .USD:
            return self.USD
        case .EUR:
            return self.EUR
        case .JPY:
            return self.JPY
        case .CNY:
            return self.CNY
        }
    }
}
