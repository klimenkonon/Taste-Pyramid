//
//  SelectFoodView.swift
//  
//
//  Created by Danylo Klymenko on 21.08.2024.
//

import SwiftUI

struct SelectFoodView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MakeOrderViewModel
    var productType: URLS
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title)
                                .foregroundColor(.yellow)
                        }
                        .padding(.top)
                        .padding(.leading)
                        
                        Text(String(describing: productType).uppercased())
                            .foregroundStyle(Color.semiYellow)
                            .font(.system(size: 34, weight: .heavy, design: .serif))
                            .padding(.leading)
                            .padding(.top)
                        
                    }
                    .frame(width: getScreenSize().width, alignment: .leading)
                    
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.products, id: \.image) { product in
                                Rectangle()
                                    .frame(width: getScreenSize().width - 30, height: 140)
                                    .cornerRadius(12)
                                    .foregroundColor(.softYellow)
                                    .padding(.vertical, 10)
                                    .overlay {
                                        HStack {
                                            AsyncImage(url: URL(string: product.image)) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 100, height: 100)
                                                    .clipShape(Circle())
                                            } placeholder: {
                                                ProgressView()
                                                    .frame(width: 100, height: 100)
                                            }
                                            .padding(.leading)
                                            
                                            VStack(alignment: .leading) {
                                                Text(product.name)
                                                    .font(.system(size: 18, weight: .light, design: .serif))
                                                    .frame(height: 100)
                                                Text(product.weight)
                                                    .font(.system(size: 14, weight: .light, design: .serif))
                                                    .padding(.bottom)
                                            }
                                            .foregroundColor(.black)
                                            .padding(.leading)
                                            Spacer()
                                            
                                            HStack {
                                                Text(String(format: "%.2f", product.price))
                                                    .font(.system(size: 22, weight: .light, design: .serif))
                                                    
                                                Button {
                                                    StorageManager.shared.addToCart(foodItem: product)
                                                    viewModel.isAlertShown.toggle()
                                                } label: {
                                                    Circle()
                                                        .frame(width: 40, height: 40)
                                                        .foregroundColor(.semiYellow)
                                                        .overlay {
                                                            Image(systemName: "plus")
                                                        }
                                                }
                                            }
                                            .foregroundColor(.black)
                                            .padding(.trailing)
                                        }
                                    }
                            }
                        }
                    }
                    
                }
            }
            .alert("The product has been successfully added to your cart.", isPresented: $viewModel.isAlertShown) {
                Button {
                    viewModel.isAlertShown.toggle()
                } label: {
                    Text("Ok")
                }
            } message: {
                
            }

        }
        .onAppear {
            NetworkManager.shared.fetchData(for: productType, as: ProductElement.self) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        viewModel.products = data
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    SelectFoodView(viewModel: MakeOrderViewModel(), productType: .food)
}
