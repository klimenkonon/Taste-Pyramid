//
//  MainView.swift
//  
//
//  Created by Danylo Klymenko on 21.08.2024.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    HStack {
                        LogoView(width: 100, height: 100)
                            
                        
                        Text("TASTE \nPYRAMID")
                            .foregroundStyle(Color.semiYellow)
                            .font(.system(size: 34, weight: .heavy, design: .serif))
                            .padding(.leading, 30)
                    }
                    
                    Spacer()
                }
                .padding(.top, 30)
                
                VStack(spacing: 40) {
                    Rectangle()
                        .frame(width: getScreenSize().width - 40, height: 220)
                        .foregroundColor(.softYellow)
                        .cornerRadius(12)
                        .overlay {
                            VStack(alignment: .leading) {
                                Text("YOUR ORDERS:")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 22, weight: .light, design: .serif))
                                    .frame(width: getScreenSize().width - 65, alignment: .leading)
                                    .padding(.top)
                                if !viewModel.orders.isEmpty {
                                    ScrollView {
                                        VStack {
                                            ForEach(viewModel.orders.reversed(), id: \.id) { order in
                                                HStack {
                                                    Text(order.orderCode ?? "")
                                                    
                                                    Spacer()
                                                    
                                                    Text(order.time ?? "")
                                                    
                                                    Spacer()
                                                    
                                                    Text(String(format: "%.2f", order.totalValue ?? 0))
                                                }
                                                .font(.system(size: 22, weight: .light, design: .serif))
                                                .foregroundColor(.black)
                                                .padding()
                                                .background {
                                                    Rectangle()
                                                        .foregroundColor(.semiYellow)
                                                        .cornerRadius(12)
                                                }
                                                .onTapGesture {
                                                    viewModel.orderToShow = order
                                                    viewModel.isDetailed.toggle()
                                                }
                                               
                                            }
                                        }
                                       
                                    }
                                } else {
                                    VStack {
                                        Spacer()
                                        
                                        Text("You don't have any orders yet. Click the button below to create your first one.")
                                            .font(.system(size: 18, weight: .light, design: .serif))
                                            .foregroundStyle(.black.opacity(0.5))
                                        
                                        Spacer()
                                    }
                                    
                                }
                              
                                
                                
                            }
                            .padding(.horizontal)
                            
                        }
                    
                    Button {
                        viewModel.isOrderShown.toggle()
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(LinearGradient(colors: [.darkYellow, .semiYellow], startPoint: .bottom, endPoint: .top))
                                .frame(width: getScreenSize().width - 90, height: 100)
                                .cornerRadius(12)
                            
                            Text("MAKE AN ORDER")
                                .foregroundStyle(.black)
                                .font(.system(size: 30, weight: .heavy, design: .serif))
                        }
                    }
                    
                }
                .padding(.top, 30)
            }
            .onAppear {
                viewModel.getOrders()
            }
        }
        .fullScreenCover(isPresented: $viewModel.isOrderShown) {
            MakeOrderView()
                .onDisappear {
                    StorageManager.shared.deleteCart()
                    viewModel.getOrders()
                }
        }
        .sheet(isPresented: $viewModel.isDetailed) {
            if let order = viewModel.orderToShow {
                OrderDetailView(order: order)
            }
        }
    }
}

//#Preview {
//    MainView()
//}

#Preview {
    TabBarView()
}
