//
//  ProductSctollView.swift
//  PharaohCoffee
//
//  Created by Danylo Klymenko on 22.08.2024.
//

import SwiftUI

struct ProductScrollView: View {
    
    var type: URLS
    @State var products: [ProductElement]?
    @State var coffee: [CoffeeElement]?
    var completion: () -> ()
    
    var body: some View {
        VStack {
            ScrollView {
                if let products = products {
                    LazyVStack(spacing: 10) {
                        ForEach(products, id: \.image) { product in
                            NavigationLink {
                                FoodDetailView(product: product) {
                                    completion()
                                }
                                .navigationBarBackButtonHidden()
                                .onAppear {
                                    completion()
                                }
                            } label: {
                                ProductCellView(product: product)
                            }
                        }
                    }
                    .padding(.bottom, 200)
                }
                if let coffee = coffee {
                    LazyVStack(spacing: 10) {
                        ForEach(coffee, id: \.coffeeID) { product in
                            NavigationLink {
                                CoffeeDetailView(coffee: product) {
                                    completion()
                                }
                                .onAppear {
                                    completion()
                                }
                                .navigationBarBackButtonHidden()
                            } label: {
                                CoffeeCellView(coffee: product)
                            }
                        }
                    }
                    .padding(.bottom, 200)
                }
            }
        }
        .onAppear {
            if type == .coffee {
                NetworkManager.shared.fetchData(for: type, as: CoffeeElement.self) { result in
                    switch result {
                    case .success(let data):
                        coffee = data
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } else {
                NetworkManager.shared.fetchData(for: type, as: ProductElement.self) { result in
                    switch result {
                    case .success(let data):
                        products = data
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            
        }
    }
}
//
//#Preview {
//    ProductSctollView()
//}
