//
//  InputView.swift
//  PlinkoBowlingClub
//
//  Created by Danylo Klymenko on 07.08.2024.
//

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecure = false
    
    var body: some View {
        VStack(spacing: 12) {
            
            if isSecure {
                ZStack {
                    Rectangle()
                        .foregroundColor(.softYellow)
                        .frame(width: getScreenSize().width - 40, height: 60)
                        .cornerRadius(12)
                        .overlay {
                            HStack {
                                Text(title)
                                    .foregroundStyle(.black)
                                    .font(.system(size: 24, weight: .light, design: .serif))
                                
                                Spacer()
                                
                                SecureField(placeholder, text: $text)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                                    .frame(width: 165)
                                    .tint(.purple)
                                    .foregroundColor(.black)
                                    .colorMultiply(.black)
                                    .padding(.trailing, 10)
                            }
                            .padding(.leading, 20)
                        }
                }
            } else {
                ZStack {
                    Rectangle()
                        .foregroundColor(.softYellow)
                        .frame(width: getScreenSize().width - 40, height: 60)
                        .cornerRadius(12)
                        .overlay {
                            HStack {
                                Text(title)
                                    .font(.system(size: 24, weight: .light, design: .serif))
                                    .foregroundStyle(.black)
                                
                                Spacer()
                                
                                TextField(placeholder, text: $text)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                                    .frame(width: 165, alignment: .leading)
                                    .tint(.purple)
                                    .foregroundColor(.black)
                                    .colorMultiply(.black)
                                    .padding(.trailing, 10)
                            }
                            .padding(.leading, 20)
                        }
                }
            }
            
            Divider()
            
        }
    }
}

//struct InputView_Previews: PreviewProvider {
//    static var previews: some View {
//        InputView(text: .constant(""), title: "Email", placeholder: "name@example.com")
//    }
//}

//
#Preview {
    LoginView(viewModel: AuthViewModel())
}

