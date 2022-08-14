//
//  Currency.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/14.
//

import Foundation
import SwiftUI

// top 10 虚拟货币
// http://www.benmuji.cn/news/20220612412.html
enum CurrencyType: String, CaseIterable, Identifiable {
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
    
    var id: String { self.rawValue }
    
    var isDigital: Bool {
        switch self {
        case .USD, .JPY, .EUR, .CNY:
            return false
        default:
            return true
        }
    }
    
    var name: String {
        switch self {
        case .BTC:
            return "BitCoin"
        case .ETH:
            return "Ethereum"
        case .BNB:
            return "Binance"
        case .DOT:
            return "Polkadot"
        case .ADA:
            return "Cardano"
        case .USDT:
            return "Tether USD"
        case .XRP:
            return "Ripple"
        case .LTC:
            return "Litecoin"
        case .LINK:
            return "ChainLink"
        case .BCH:
            return "Bitcoin Cash"
        case .USD:
            return "US Dollar"
        case .EUR:
            return "Eurodollar"
        case .JPY:
            return "Yen"
        case .CNY:
            return "China Yuan"
        }
    }
    
    var color: Color {
        switch self {
        case .BTC:
            return .blue
        case .ETH:
            return .purple
        case .BNB:
            return .red
        case .DOT:
            return Color(.sRGB, red: 0.3, green: 0.7, blue: 0.5, opacity: 1.0)
        case .ADA:
            return Color(.sRGB, red: 0.5, green: 0.3, blue: 0.7, opacity: 1.0)
        case .USDT:
            return .green
        case .XRP:
            return .gray
        case .LTC:
            return Color(.sRGB, red: 0.7, green: 0.3, blue: 0.5, opacity: 1.0)
        case .LINK:
            return .pink
        case .BCH:
            return .orange
        case .USD:
            return .green
        case .EUR:
            return .blue
        case .JPY:
            return .gray
        case .CNY:
            return .red
        }
    }
}
