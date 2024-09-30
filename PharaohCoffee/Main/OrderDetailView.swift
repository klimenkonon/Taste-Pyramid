//
//  OrderDetailView.swift
//  
//
//  Created by Danylo Klymenko on 25.08.2024.
//

import SwiftUI

struct OrderDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    var order: RealmOrder
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            
            
            ScrollView {
                VStack {
                    Text("Order №: \(order.orderCode ?? "")")
                        .foregroundStyle(Color.semiYellow)
                        .font(.system(size: 32, weight: .bold, design: .serif))
                        .padding(.top, 40)
                    
                    if let data = order.orderQR, let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .interpolation(.none)
                            .resizable()
                            .frame(width: 250, height: 250)
                    }
                 
                    
                    Text(String(format: "%.2f", order.totalValue ?? 0))
                        .foregroundStyle(Color.semiYellow)
                        .font(.system(size: 32, weight: .bold, design: .serif))
                        .padding(.top, 40)
                    
                    VStack(alignment: .leading) {
                        ForEach(order.elements, id: \.id) { element in
                            HStack {
                                Text(element.name ?? "")
                                
                                Spacer()
                                
                                Text("x\(element.quantity ?? 0)")
                            }
                            .foregroundColor(.darkYellow)
                            .padding(.horizontal, 40)
                                
                        }
                        .padding(.vertical, 10)
                    }
                    .padding(.top)
                }
            }
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.yellow)
                            .bold()
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    TabBarView()
}
