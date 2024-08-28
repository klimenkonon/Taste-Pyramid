//
//  MakeOrderViewModel.swift
//  PharaohCoffee
//
//  Created by Danylo Klymenko on 21.08.2024.
//

import Foundation


class MakeOrderViewModel: ObservableObject {
    @Published var cart: RealmCart?
    @Published var time = Date()
    
    @Published var products: [ProductElement] = []
    @Published var isMailShown = false
    @Published var isAlertShown = false
    
    func roundedDate(byAdding minutes: Int, to date: Date) -> Date {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_RU")
        let nextDate = calendar.date(byAdding: .minute, value: minutes, to: date)!
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: nextDate)
        return calendar.date(from: components) ?? nextDate
    }

    func formattedTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func getCart() {
        guard let cart = StorageManager.shared.carts.first else { return }
        self.cart = cart
    }
    
    func addProduct(element: RealmCartElement) {
        let product = ProductElement(name: element.name ?? "", image: "", description: "", recipeIngredient: [""], category: .food, price: element.price ?? 0, weight: "")
        StorageManager.shared.addToCart(foodItem: product)
        getCart()
    }
    
    func removeProduct(element: RealmCartElement) {
        StorageManager.shared.removeElement(element: element)
        getCart()
    }
    
    func makeReservMessage(name: String, email: String) -> String {
        var orderNames: [[String : Int]] = []
        if let elements = cart?.elements {
            for element in elements {
                let newElementOrder = [element.name ?? "" : element.quantity ?? 0]
                orderNames.append(newElementOrder)
            }
        }
        
        let message = """
Time: \(time)
Email: \(email)
Name: \(name)
Order: \(orderNames)
"""
        
        return message
    }
    
    func timeString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}

