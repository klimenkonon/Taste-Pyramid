//
//  NetworkManager.swift
//  
//
//  Created by Danylo Klymenko on 21.08.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidData
    case invalidResponse
}

enum URLS: String {
    case hot = "https://api.jsonserve.com/udvi-c"
    case iced = "https://api.jsonserve.com/O1dnCb"
    case food = "https://api.jsonserve.com/F4ZObB"
    case coffee = "https://api.jsonserve.com/lmnyUm"
}

class NetworkManager  {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData<T: Decodable>(for selection: URLS, as type: T.Type, completion: @escaping (Result<[T], Error>) -> Void) {
        
        guard let url = URL(string: selection.rawValue) else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            do {
                let activities = try JSONDecoder().decode([T].self, from: data)
                completion(.success(activities))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

}
