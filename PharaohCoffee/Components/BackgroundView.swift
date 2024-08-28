//
//  BackgroundView.swift
//  PharaohCoffee
//
//  Created by Danylo Klymenko on 20.08.2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .ignoresSafeArea()
                .overlay {
                    Image("background")
                        .resizable()
                        .scaledToFill()
                        .frame(width: getScreenSize().width, height: getScreenSize().height)
                        .scaleEffect(1.05)
                }
        }
    }
}

#Preview {
    BackgroundView()
}
