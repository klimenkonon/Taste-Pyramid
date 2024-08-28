//
//  Product.swift
//  PharaohCoffee
//
//  Created by Danylo Klymenko on 21.08.2024.
//

import Foundation

struct ProductElement: Codable {
    let name: String
    let image: String
    let description: String
    let recipeIngredient: [String]
    let category: Category
    let price: Double
    let weight: String
}

enum Category: String, Codable {
    case food = "FOOD"
    case icedBeverages = "ICED BEVERAGES"
    case hotBeverages = "HOT BEVERAGES"
}
