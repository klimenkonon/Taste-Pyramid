//
//  OnBoardingView.swift
//  
//
//  Created by Danylo Klymenko on 20.08.2024.
//

import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                
                LogoView(width: 300, height: 300)
                    .padding(.top, 50)
                
                Rectangle()
                    .frame(width: getScreenSize().width - 40, height: 350)
                    .cornerRadius(12)
                    .foregroundColor(.softYellow)
                
                Button {
                     
                } label: {
                    ZStack {
                        Rectangle()
                            .fill(LinearGradient(colors: [.darkYellow, .semiYellow], startPoint: .bottom, endPoint: .top))
                            .frame(width: getScreenSize().width - 40, height: 100)
                            .cornerRadius(12)
                        
                        Text("START")
                            .foregroundStyle(.black)
                            .font(.system(size: 34, weight: .heavy, design: .serif))
                    }
                }
                .padding(.top)
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    OnBoardingView()
}
