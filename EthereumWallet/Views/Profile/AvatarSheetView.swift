//
//  AvatarSheetView.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/13.
//

import SwiftUI

struct AvatarCell: View {
    @Binding var selectedIndex: Int
    var name: String
    let index: Int
    var body: some View {
        Image(name)
            .frame(width: 64, height: 64, alignment: .center)
            .border(.blue, width: selectedIndex == index ? 2 : 0)
            .cornerRadius(4)
            .onTapGesture {
                selectedIndex = index
            }
    }
}

struct AvatarSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedIndex: Int
    var names: [String]
    
    private let columns = 3
    private let rows = 3

    var body: some View {
        Text("Choose Your Avatar")
            .font(.title2)
            .bold()
            .padding()
        
        VStack {
            ForEach(0..<rows) { i in
                HStack {
                    ForEach(0..<columns) { j in
                        AvatarCell(selectedIndex: $selectedIndex, name: names[i * columns + j], index: i * columns + j)
                    }
                }
            }
        }.padding()
        
        Button("Confirm") {
            presentationMode.wrappedValue.dismiss()
        }
        .padding(.init(top: 6, leading: 10, bottom: 6, trailing: 10))
        .foregroundColor(Color.white)
        .background(Color.blue)
        .font(.title3)
        .cornerRadius(6)
        .padding()
        
    }
}
