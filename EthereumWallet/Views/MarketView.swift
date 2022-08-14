//
//  MarketView.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/13.
//

import SwiftUI

struct DayCell: View {
    
    @State var showValues = false
    @Binding var selectedIdx: Int
    @Binding var low: Double
    @Binding var high: Double
    @Binding var open: Double
    @Binding var close: Double
    
    var index: Int
    
    var body: some View {
        VStack {
            Text(String(format: "%.1f", high))
                .font(.system(size: 8))
                .frame(width: 50, height: 10, alignment: .center)
            Rectangle()
                .fill(selectedIdx == index ? .red : .blue)
                .cornerRadius(4)
            Text(String(format: "%.2f", low))
                .font(.system(size: 8))
                .frame(height: 10, alignment: .center)
        }.onTapGesture {
            if selectedIdx == index {
                selectedIdx = -1
            } else {
                selectedIdx = index
            }
        }
    }
}

struct MarketView: View {
    @EnvironmentObject var netWork: Network
    
    @State var selectedIdx: Int = -1
    
    private let graphHeight: Double = 400
    private let cellWidth: CGFloat = 40
    
    private var selectOpen: String {
        if selectedIdx > -1 && selectedIdx < netWork.dayModels.count {
            return "\(netWork.dayModels[selectedIdx].open)"
        }
        return ""
    }
    
    private var selectClose: String {
        if selectedIdx > -1 && selectedIdx < netWork.dayModels.count {
            return "\(netWork.dayModels[selectedIdx].close)"
        }
        return ""
    }
    
    var minValue: Double {
        var result: Double = .infinity
        for day in netWork.dayModels {
            if day.low < result {
                result = day.low
            }
        }
        return result
    }
    
    var maxValue: Double {
        var result = 0.0
        for day in netWork.dayModels {
            if day.high > result {
                result = day.high
            }
        }
        return result
    }
    
    
    var body: some View {
        
        VStack {
            Text("BTC last 7 Days(USD):")
                .bold()
                .font(.title2)
                .padding(.init(top: 10, leading: 10, bottom: 50, trailing: 10))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    let minValue = self.minValue
                    let maxValue = self.maxValue
                    
                    ForEach(0..<netWork.dayModels.count) { i in
                        let (topPadding, bottomPadding) = getPadding(min: minValue, max: maxValue, day: netWork.dayModels[i])
                        let height = CGFloat(graphHeight + 20) - topPadding - bottomPadding
                        DayCell(selectedIdx: $selectedIdx,
                                low: $netWork.dayModels[i].low,
                                high: $netWork.dayModels[i].high,
                                open: $netWork.dayModels[i].open,
                                close: $netWork.dayModels[i].close,
                                index: i)
                            .frame(width: cellWidth, height: height + 20)
                            .padding(.init(top: topPadding, leading: 10,
                                           bottom: bottomPadding, trailing: 0))
                    }
                }
            }
            .frame(height: graphHeight + 20)
            
            HStack {
                Text("Open Price: \(selectOpen)")
                    .font(.footnote)
                    .frame(width: 150, alignment: .leading)
                    .padding()
                Spacer()
                Text("Close Price: \(selectClose)")
                    .font(.footnote)
                    .frame(width: 150, alignment: .leading)
                    .padding()
            }.padding()
        }
        .onAppear() {
            netWork.getLastWeekHistory()
        }
    }
}

extension MarketView {
    func getPadding(min: Double, max: Double, day: HistoryDayModel) -> (CGFloat, CGFloat) {
        let topPadding = CGFloat((day.low - min) / (max - min) * graphHeight)
        let bottomPadding = CGFloat((max - day.high) / (max - min) * graphHeight)
        return (bottomPadding, topPadding)
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView().environmentObject(Network())
    }
}
