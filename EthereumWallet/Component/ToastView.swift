//
//  ToastView.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/14.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    
    @Binding var isShowing: Bool
    @Binding var isFailure: Bool
    @Binding var message: String
    let duration: TimeInterval
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: isFailure ? "xmark.circle" : "heart.fill")
                        Text(message)
                            .font(.footnote)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 5)
                }
                .padding()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            isShowing = false
                        }
                    }
                }
            }
            
        }
    }
}

extension View {
    func toast(isShowing: Binding<Bool>, message: Binding<String>, isFailure: Binding<Bool>, duration: TimeInterval = 2) -> some View {
        modifier(ToastModifier(isShowing: isShowing, isFailure: isFailure, message: message, duration: duration))
    }
}
