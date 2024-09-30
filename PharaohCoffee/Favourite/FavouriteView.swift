//
//  FavouriteView.swift
//  
//
//  Created by Danylo Klymenko on 22.08.2024.
//

import SwiftUI

struct FavouriteView: View {
    
    @StateObject private var viewModel = FavouriteViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    HStack {
                        Text("FAVOURITE")
                            .foregroundStyle(Color.semiYellow)
                            .font(.system(size: 34, weight: .heavy, design: .serif))
                        
                        Spacer()
                    }
                    .padding(.horizontal, 40)
                    
                    ScrollView {
                        VStack {
                            ForEach(viewModel.favourites, id: \.id) { item in
                                Rectangle()
                                    .foregroundColor(.softYellow)
                                    .frame(width: getScreenSize().width - 60, height: 130)
                                    .cornerRadius(12)
                                    .overlay {
                                        HStack {
                                            Image(uiImage: UIImage(data: item.imageData ?? Data()) ?? UIImage())
                                                .resizable()
                                                .scaledToFill()
//                                                .clipShape(Circle())
                                                .frame(width: 80, height: 80)
                                                .cornerRadius(12)
                                                .padding(.leading)
                                            
                                            VStack(alignment: .leading) {
                                                Text(item.name)
                                                    .font(.system(size: 16, weight: .semibold, design: .serif))
                                            }
                                            .multilineTextAlignment(.leading)
                                            .foregroundStyle(.black)
                                            .padding(.trailing)
                                            .padding(.leading, 10)
                                            
                                            Spacer()
                                            
                                            Button {
                                                StorageManager.shared.deleteFavourite(element: item)
                                                viewModel.favourites = Array(StorageManager.shared.favourites)
                                            } label: {
                                                Image(systemName: "heart.fill")
                                                    .font(.largeTitle)
                                                    .foregroundColor(.darkYellow)
                                                    .padding(.trailing)
                                            }
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.favourites = Array(StorageManager.shared.favourites)
            }
        }
    }
}

#Preview {
    FavouriteView()
}
