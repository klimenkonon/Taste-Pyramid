//
//  MainViewModel.swift
//  
//
//  Created by Danylo Klymenko on 21.08.2024.
//

import SwiftUI

class MainViewModel: ObservableObject {
    
    @Published var isOrderShown = false
    @Published var isDetailed = false
    @Published var orders: [RealmOrder] = []
    @Published var orderToShow: RealmOrder?
    
    
    func getOrders() {
        orders = Array(StorageManager.shared.orders)
    }
}
