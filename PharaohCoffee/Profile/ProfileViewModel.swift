//
//  ProfileViewModel.swift
//  PharaohCoffee
//
//  Created by Danylo Klymenko on 22.08.2024.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var isErrorShown = false
    @Published var isSuggestionShown = false
    @Published var isAlertShown = false
    @Published var isDeleteAlertShown = false
    
    func openPrivacyPolicy() {
        if let url = URL(string: "https://sites.google.com/view/pyramidoftaste/privacy-policy") {
            UIApplication.shared.open(url)
        }
    }
}
