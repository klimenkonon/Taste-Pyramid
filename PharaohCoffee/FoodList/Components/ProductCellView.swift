//
//  ProductCellView.swift
//  PharaohCoffee
//
//  Created by Danylo Klymenko on 22.08.2024.
//

import SwiftUI

struct ProductCellView: View {
    
    var product: ProductElement
    
    var body: some View {
        Rectangle()
            .foregroundColor(.softYellow)
            .frame(width: getScreenSize().width - 60, height: 170)
            .cornerRadius(12)
            .overlay {
                HStack {
                    
                    AsyncImage(url: URL(string: product.image)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 120, height: 120)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 120, height: 120)
                    }
                    .padding(.leading, 10)
                    
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .font(.system(size: 18, weight: .semibold, design: .serif))
                        Text(product.description)
                            .font(.system(size: 12, weight: .light, design: .serif))
                            .frame(height: 50)
                        
                        Text(product.weight)
                            .font(.system(size: 12, weight: .light, design: .serif))
                    }
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.black)
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                        .padding(.trailing)
                    
                }
            }
    }
}

#Preview {
    FoodListView(){}
}
