//
//  MakeOrderView.swift
//  
//
//  Created by Danylo Klymenko on 21.08.2024.
//

import SwiftUI
import MessageUI

struct MakeOrderView: View {
    
    init() {
        UIDatePicker.appearance().tintColor = UIColor.init(.white)
    }
    
    @Environment(\.dismiss) var dismiss
    
    
    //Private Properties
    @StateObject private var viewModel = MakeOrderViewModel()
    @State private var messageAlert = false
    @State private var isClosed = false
    
    
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150, maximum: 250))
    ]
    private let selection = [URLS.iced, URLS.hot, URLS.food]
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.semiYellow)
                            .font(.title)
                    }
                    .frame(width: getScreenSize().width - 40, alignment: .leading)
                    //MARK: - Header
                    ScrollView {
                        VStack {
                            Text("ORDER")
                                .foregroundStyle(Color.semiYellow)
                                .font(.system(size: 34, weight: .heavy, design: .serif))
                                .frame(width: getScreenSize().width - 40, alignment: .leading)
                                .padding(.top)
                            
                            //MARK: - Time Selection
                            
                            HStack {
                                Text("Time")
                                    .foregroundStyle(Color.semiYellow)
                                    .font(.system(size: 34, weight: .light, design: .serif))
                                
                                
                                Spacer()
                                
                                TimeSelectionView(selectedTime: $viewModel.time, isClosed: $isClosed)
                                
                            }
                            .padding(.horizontal, 20)
                            
                            //MARK: - Cart View
                            if let cart = viewModel.cart, !cart.elements.isEmpty {
                                VStack(alignment: .leading) {
                                    ForEach(cart.elements, id: \.id) { element in
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(element.name ?? "")
                                                    .multilineTextAlignment(.leading)
                                                    .font(.system(size: 16, weight: .light, design: .serif))
                                                    .padding(.leading)
                                            }
                                            
                                            
                                            Spacer()
                                            
                                            
                                            Button {
                                                viewModel.removeProduct(element: element)
                                            } label: {
                                                Image(systemName: "minus")
                                                    .foregroundStyle(.black)
                                            }
                                            
                                            Text("\(element.quantity ?? 0)")
                                                .font(.system(size: 18, weight: .light, design: .serif))
                                            
                                            Button {
                                                viewModel.addProduct(element: element)
                                            } label: {
                                                Image(systemName: "plus")
                                                    .foregroundStyle(.black)
                                            }
                                            .padding(.trailing)
                                        }
                                        .padding(.vertical)
                                        .background {
                                            Color.semiYellow
                                                .cornerRadius(12)
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                .padding()
                                .background {
                                    Rectangle()
                                        .frame(width: getScreenSize().width - 40)
                                        .cornerRadius(12)
                                        .foregroundColor(.softYellow)
                                }
                            }
                            
                            //MARK: - Total View
                            Rectangle()
                                .frame(width: getScreenSize().width - 40, height: 60)
                                .cornerRadius(12)
                                .foregroundColor(.softYellow)
                                .overlay {
                                    HStack {
                                        Text("TOTAL:")
                                            .foregroundStyle(Color.black)
                                            .font(.system(size: 30, weight: .light, design: .serif))
                                        Spacer()
                                        
                                        if let cart = viewModel.cart, let value = cart.totalValue {
                                            Text(String(format: "%.2f", value))
                                                .font(.system(size: 22, weight: .light, design: .serif))
                                                .padding(.trailing)
                                                .foregroundStyle(Color.black)
                                        }
                                    }
                                    .padding(.leading)
                                }
                            
                            //MARK: - Food Selection
                            Text("SELECT")
                                .foregroundStyle(Color.semiYellow)
                                .font(.system(size: 34, weight: .heavy, design: .serif))
                                .frame(width: getScreenSize().width - 40, alignment: .leading)
                                .padding(.top)
                            
                            LazyVGrid(columns: adaptiveColumn, spacing: 30) {
                                ForEach(selection, id:\.self) { type in
                                    NavigationLink {
                                        SelectFoodView(viewModel: viewModel, productType: type)
                                            .navigationBarBackButtonHidden()
                                    } label: {
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(.softYellow)
                                                .frame(width: 170, height: 120)
                                                .cornerRadius(12)
                                            
                                            Text(String(describing: type).uppercased())
                                                .foregroundStyle(Color.black)
                                                .font(.system(size: 34, weight: .light, design: .serif))
                                        }
                                    }
                                }
                            }
                            
                            //MARK: - MakeOrder Button
                            Button {
                                if MFMailComposeViewController.canSendMail() {
                                    viewModel.isMailShown.toggle()
                                } else {
                                    messageAlert.toggle()
                                }
                                // StorageManager.shared.createOrder(time: viewModel.timeString(from: viewModel.time))
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .fill(LinearGradient(colors: [.darkYellow, .semiYellow], startPoint: .bottom, endPoint: .top))
                                        .frame(width: getScreenSize().width - 40, height: 100)
                                        .cornerRadius(12)
                                    
                                    Text("MAKE ORDER")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 34, weight: .heavy, design: .serif))
                                }
                            }
                            .disabled(isClosed)
                            .padding(.top, 40)
                        }
                        .padding(.bottom, 140)
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .onAppear {
                viewModel.getCart()
            }
            //MARK: - MessageView
            .sheet(isPresented: $viewModel.isMailShown) {
                MailComposeView(isShowing: $viewModel.isMailShown, subject: "Order message", recipientEmail: "pharaohCoffe@mail.com", textBody: viewModel.makeReservMessage(name: "", email: "")) { result, error in
                    switch result {
                    case .cancelled:
                        print("Mail cancelled")
                    case .saved:
                        print("Mail saved")
                    case .sent:
                        print("Mail sent")
                        StorageManager.shared.createOrder(time: viewModel.timeString(from: viewModel.time))
                        dismiss()
                    case .failed:
                        print("Mail failed: \(error?.localizedDescription ?? "Unknown error")")
                    @unknown default:
                        print("Unknown result")
                    }
                }
              
            }
            //MARK: - Message Alert
            .alert("Unable to send email", isPresented: $messageAlert) {
                Button {
                    messageAlert.toggle()
                } label: {
                    Text("Ok")
                }
            } message: {
                Text("Your device does not have a mail client configured. Please configure your mail or contact support on our website.")
            }
        }
    }
    
}

#Preview {
    MakeOrderView()
}
