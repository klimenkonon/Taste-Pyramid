//
//  QRView.swift
//  PharaohCoffee
//
//  Created by Danylo Klymenko on 22.08.2024.
//

import SwiftUI

struct QRView: View {
    
    @State private var code = ""
    @State private var characters: [String] = []
    @State private var isLoyaltyShown = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    HStack {
                        Text("QR")
                            .foregroundStyle(Color.semiYellow)
                            .font(.system(size: 34, weight: .heavy, design: .serif))
                            
                        Spacer()
                        
                        Button {
                            isLoyaltyShown.toggle()
                        } label: {
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.semiYellow)
                                .overlay {
                                    Image(systemName: "info.bubble")
                                        .foregroundColor(.black)
                                }
                        }
                        //.padding(.top)
                    }
                    .padding(.horizontal, 40)
                    
                    
                    Rectangle()
                        .frame(width: 265, height: 265)
                        .foregroundColor(.softYellow)
                        .cornerRadius(12)
                        .overlay {
                            Image("qr")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 240, height: 240)
                        }
                    
                    
                    HStack {
                        ForEach(0...4, id: \.self) { index in
                            Image("cup")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 65, height: 70)
                                .colorMultiply(index == 0 ? .white : .black)
                                .shadow(color: .yellow, radius: 3)
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    
                    
                    HStack(spacing: 5) {
                        ForEach(0..<characters.count, id: \.self) { index in
                            Rectangle()
                                .foregroundColor(.softYellow)
                                .frame(width: 55, height: 55)
                                .cornerRadius(12)
                                .overlay {
                                    Text(String(characters[index]))
                                        .foregroundStyle(.black)
                                }
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                  
                }
            }
            .sheet(isPresented: $isLoyaltyShown) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                    
                    VStack {
                        Text("Loyalty program")
                            .font(.system(size: 28, weight: .bold, design: .serif))

                        Text("To join the loyalty program, you need to be a registered user. Simply present your QR code to the manager or barista when purchasing any coffee. After buying five cups, you'll get the sixth one for free.")
                            .font(.system(size: 18, weight: .regular, design: .serif))
                            .padding(.top)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                    .foregroundColor(.black)
                }
                .presentationDetents([.height(250)])
            }
            .onAppear {
                code = UserDefaults.standard.string(forKey: "code") ?? ""
                code = code.replacingOccurrences(of: " ", with: "")
                characters = []
                for i in code {
                    characters.append(String(i))
                }
                characters.remove(at: 0)
                characters.remove(at: 0)
            }
        }
    }
}

#Preview {
    QRView()
}
