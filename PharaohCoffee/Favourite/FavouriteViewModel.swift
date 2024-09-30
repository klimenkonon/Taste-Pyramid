//
//  FavouriteViewModel.swift
//  
//
//  Created by Danylo Klymenko on 26.08.2024.
//

import Foundation


class FavouriteViewModel: ObservableObject {
    
    @Published var favourites: [RealmFavourite] = []
    
}
