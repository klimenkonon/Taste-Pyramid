//
//  Root.swift
//  
//
//  Created by Danylo Klymenko on 26.08.2024.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                TabBarView()
                    .environmentObject(viewModel)
            } else {
                LoginView(viewModel: viewModel)
                  
            }
        }
        .onAppear {
            AppDelegate.orientationLock = .portrait
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }
    }
}

#Preview {
    RootView()
}
