//
//  ProgressAlert.swift
//  
//
//  Created by Danylo Klymenko on 26.08.2024.
//

import SwiftUI

struct ProgressAlertView: View {
    
    var text: String
    @Binding var switcher: Bool
    var completion: () -> ()
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(.white.opacity(0.1))
            
            if switcher {
                Rectangle()
                    .frame(width: 290, height: 250)
                    .foregroundColor(.white.opacity(0.9))
                    .blur(radius: 5)
                    .cornerRadius(24)
                    .shadow(color: .white.opacity(0.5), radius: 5)
                    .overlay {
                        ProgressView()
                            .tint(.yellow)
                            .controlSize(.large)
                    }
            } else {
                Rectangle()
                    .frame(width: 290, height: 250)
                    .foregroundColor(.white.opacity(0.9))
                    .blur(radius: 5)
                    .cornerRadius(24)
                    .shadow(color: .white.opacity(0.5), radius: 5)
                    .overlay {
                        VStack {
                            Text(text)
                                .foregroundStyle(.black)
                                .font(.system(size: 24, weight: .semibold, design: .monospaced))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            Button {
                                completion()
                            } label: {
                               Image("xmark")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                            }
                            .padding(.top, 30)
                        }
                       
                    }
            }
        }
    }
}
