//
//  HistoryModel.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/14.
//

import Foundation

//time: 1659484800
//high: 23615.71
//low: 22695.67
//open: 22991.49
//volumefrom: 44757.6
//volumeto: 1039306431.63
//close: 22825.25
//conversionType: "direct"
//conversionSymbol: ""

struct HistoryDayModel: Decodable, Identifiable, Hashable {
    var id: String { UUID().uuidString }
    var time: Int64 = 0
    var high: Double = 0
    var low: Double = 0
    var open: Double = 0
    var close: Double = 0
    var volumeFrom: Double = 0
    var volumeTo: Double = 0
    
    enum CodingKeys: String, CodingKey {
        case time, high, low, open, close
        case volumeFrom = "volumefrom"
        case volumeTo = "volumeto"
    }
}

struct HistoryWeekModel: Decodable {
    var timeFrom: Int64
    var timeTo: Int64
    var dayModels: [HistoryDayModel]
    
    enum CodingKeys: String, CodingKey {
        case timeFrom = "TimeFrom"
        case timeTo = "TimeTo"
        case dayModels = "Data"
    }
}

struct HistoryWeekWrapperModel: Decodable {
    var message: String
    var weekModel: HistoryWeekModel
    var response: String
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case weekModel = "Data"
        case response = "Response"
    }
}
