//
//  NetworkManager.swift
//  Movies
//
//  Created by Guillaume Ramey on 04/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import UIKit
import Combine

enum NetworkError: String, Error {
    case encodingString = "network error encodingString"
    case badURL = "network error badURL"
    case error = "unknown error"
    case noData = "network error noData"
    case noResult = "network error noResult"
    case noResponse = "network error noResponse"
}

struct NetworkManager {
    static var shared = NetworkManager()
    private var task: URLSessionDataTask!
    private let session: URLSession
    private let apiURL = "http://omdbapi.com/?"
    private let apiKey = "533d51ab"
    
    init(session: URLSession = .shared) {
        self.session = session
    }

    func searchMovie(title: String, completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        
        let stringURL = apiURL
            + "apikey=\(apiKey)"
            + "&type=movie"
            + "&s=\(title)"
        
        guard let url = URL(string: stringURL) else {
            completion(.failure(.badURL))
            return
        }

        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.noResponse))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }

                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(decodedResponse.search))
                } catch {
                    completion(.failure(.noResult))
                }
            }
        }.resume()
    }
}
