//
//  User.swift
//  
//
//  Created by Danylo Klymenko on 26.08.2024.
//

import Foundation


struct User: Codable, Identifiable {
    
    let id: String
    let fullname: String
    let email: String
    
}
