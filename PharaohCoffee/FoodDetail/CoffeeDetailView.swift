//
//  FoodDetailView.swift
//  
//
//  Created by Danylo Klymenko on 22.08.2024.
//

import SwiftUI

struct CoffeeDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    var coffee: CoffeeElement
    var completion: () -> ()
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    HStack {
                        Button {
                            dismiss()
                            completion()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title)
                                .foregroundColor(.yellow)
                        }
                        .padding(.top)
                        .padding(.leading)
                        
                       
                    }
                    .frame(width: getScreenSize().width, alignment: .leading)
                    
                    ScrollView {
                        VStack {
                            
                            HStack {
                                Text(coffee.name)
                                    .foregroundStyle(Color.semiYellow)
                                    .font(.system(size: 34, weight: .heavy, design: .serif))
                                    
                                Spacer()
                            }
                            .padding(.top)
                            .padding(.horizontal, 20)
                        }
                        
                        VStack {
                            Rectangle()
                                .frame(width: 330, height: 270)
                                .foregroundColor(.softYellow)
                                .cornerRadius(12)
                                .overlay {
                                    AsyncImage(url: URL(string: coffee.imageURL)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 305)
                                            .cornerRadius(12)
                                        
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 305, height:  270)
                                    }

                                }
                            
                            Text("\(coffee.weight)")
                                .foregroundColor(.semiYellow)
                                .font(.system(size: 18, weight: .light, design: .serif))
                                .frame(width: 305,alignment: .leading)
                            
                            Text(coffee.region)
                                .foregroundColor(.semiYellow)
                                .font(.system(size: 18, weight: .light, design: .serif))
                                .frame(width: 305,alignment: .leading)
                            
                            Text(coffee.description)
                                .foregroundColor(.semiYellow)
                                .font(.system(size: 18, weight: .light, design: .serif))
                                .padding(.horizontal, 20)
                                .padding(.top)
                            
                            Text("Flavor:")
                                .foregroundColor(.semiYellow)
                                .font(.system(size: 22, weight: .semibold, design: .serif))
                                .padding(.horizontal, 20)
                                .padding(.top)
                                .frame(width: getScreenSize().width, alignment: .leading)
                            
                            VStack(alignment: .leading) {
                                ForEach(coffee.flavorProfile, id: \.self) { text in
                                    Text(text)
                                        .foregroundColor(.black)
                                        .padding()
                                        .background {
                                            Color.softYellow
                                        }
                                        .cornerRadius(12)
                                }
                            }
                            .padding(.top)
                            .padding(.horizontal, 20)
                            .frame(width: getScreenSize().width, alignment: .leading)
                            
                            Text("Grind Option:")
                                .foregroundColor(.semiYellow)
                                .font(.system(size: 22, weight: .semibold, design: .serif))
                                .padding(.horizontal, 20)
                                .padding(.top)
                                .frame(width: getScreenSize().width, alignment: .leading)
                            
                            VStack(alignment: .leading) {
                                ForEach(coffee.grindOption, id: \.self) { text in
                                    Text(text.rawValue)
                                        .foregroundColor(.black)
                                        .padding()
                                        .background {
                                            Color.softYellow
                                        }
                                        .cornerRadius(12)
                                }
                            }
                            .padding(.top)
                            .padding(.horizontal, 20)
                            .frame(width: getScreenSize().width, alignment: .leading)
                        }
                        .padding(.bottom, 100)
                    }
                }
                
                
                
            }
        }
    }
}

