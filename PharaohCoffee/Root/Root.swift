//
//  Root.swift
//  PharaohCoffee
//
//  Created by Danylo Klymenko on 26.08.2024.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                TabBarView()
                    .environmentObject(viewModel)
            } else {
                LoginView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    RootView()
}
