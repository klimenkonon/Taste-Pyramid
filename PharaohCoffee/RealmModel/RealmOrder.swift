//
//  RealmOrderElement.swift
//  
//
//  Created by Danylo Klymenko on 25.08.2024.
//

import Foundation
import RealmSwift

class RealmOrder: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var totalValue: Double?
    @Persisted var time: String?
    @Persisted var orderCode: String?
    @Persisted var orderQR: Data?
    
    @Persisted var elements = RealmSwift.List<RealmOrderElement>()
}

class RealmOrderElement: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name: String?
    @Persisted var price: Double?
    @Persisted var quantity: Int?
}

class RealmCart: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var totalValue: Double?    
    @Persisted var elements = RealmSwift.List<RealmCartElement>()
}

class RealmCartElement: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name: String?
    @Persisted var price: Double?
    @Persisted var quantity: Int?
}


