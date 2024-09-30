//
//  FoodDetailView.swift
//  
//
//  Created by Danylo Klymenko on 22.08.2024.
//

import SwiftUI

struct FoodDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    var product: ProductElement
    var completion: () -> ()
    @State var isFavourite = false
    
    var body: some View {
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
                    
                    Spacer()
                    
                    Button {
                        if isFavourite {
                            StorageManager.shared.deleteFavourite(withName: product.name)
                            isFavourite = false
                        } else {
                            var image = Data()
                            
                            imageDataFromURL(product.image) { data in
                                if let imageData = data {
                                    image = imageData
                                    print("Image data loaded successfully")
                                } else {
                                    
                                    print("Failed to load image data")
                                }
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                StorageManager.shared.addFavourite(name: product.name, imageData: image)

                            }
                            isFavourite = true
                        }
                        
                    } label: {
                        Image(systemName: isFavourite ? "heart.fill" : "heart")
                            .font(.title)
                            .foregroundColor(.yellow)
                    }
                    .padding(.top)
                    .padding(.trailing)
                }
                
                ScrollView {
                    VStack {
                        
                        HStack {
                            Text(product.name)
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
                                AsyncImage(url: URL(string: product.image)) { image in
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
                        
                        Text(product.weight)
                            .foregroundColor(.semiYellow)
                            .font(.system(size: 18, weight: .light, design: .serif))
                            .frame(width: 305,alignment: .leading)
                        
                        Text(product.description)
                            .foregroundColor(.semiYellow)
                            .font(.system(size: 18, weight: .light, design: .serif))
                            .padding(.horizontal, 20)
                            .padding(.top)
                        
                        Text("Ingredients:")
                            .foregroundColor(.semiYellow)
                            .font(.system(size: 22, weight: .semibold, design: .serif))
                            .padding(.horizontal, 20)
                            .padding(.top)
                            .frame(width: getScreenSize().width, alignment: .leading)
                        
                        VStack(alignment: .leading) {
                            ForEach(product.recipeIngredient, id: \.self) { text in
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
                    }
                    .padding(.bottom, 100)
                }
            }
        }
        .onAppear {
            isFavourite = StorageManager.shared.objectExists(withName: product.name)
        }
    }
}

