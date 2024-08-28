//
//  RealmFavourite.swift
//  PharaohCoffee
//
//  Created by Danylo Klymenko on 25.08.2024.
//

import Foundation
import RealmSwift

class RealmFavourite: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name: String = ""
    @Persisted var imageData: Data?
}
