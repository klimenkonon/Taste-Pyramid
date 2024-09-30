//
//  Coffee.swift
//  
//
//  Created by Danylo Klymenko on 22.08.2024.
//

import Foundation

// MARK: - CoffeeElement
struct CoffeeElement: Codable {
    let id: String
    let coffeeID: Int
    let name, description: String
    let price: Double
    let region: String
    let weight: Int
    let flavorProfile: [String]
    let grindOption: [GrindOption]
    let roastLevel: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case coffeeID = "id"
        case name, description, price, region, weight
        case flavorProfile = "flavor_profile"
        case grindOption = "grind_option"
        case roastLevel = "roast_level"
        case imageURL = "image_url"
    }
}

enum GrindOption: String, Codable {
    case cafetiere = "Cafetiere"
    case espresso = "Espresso"
    case filter = "Filter"
    case frenchPress = "French press"
    case grindOptionWholeBean = "Whole bean"
    case pourOver = "Pour Over"
    case wholeBean = "Whole Bean"
}


extension CoffeeElement {
    static let MOCK = CoffeeElement(id: "1", coffeeID: 1, name: "Signature Blend", description: "A rich, full-bodied coffee with notes of dark chocolate and black cherry. Grown on the slopes of a mist-covered mountain in Central America.", price: 100, region: "Central America", weight: 500, flavorProfile: ["Dark Chocolate", "Black Cherry"], grindOption: [GrindOption.cafetiere], roastLevel: 4, imageURL: "https://iili.io/H8Y78Qt.webp")
}
