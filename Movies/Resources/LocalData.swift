//
//  LocalData.swift
//  Movies
//
//  Created by Guillaume Ramey on 14/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import Foundation

let movieData: Movie = load("MovieData.json")
let movieSearchData: [Movie] = load("MovieSearchData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

var MY_MOVIES = [
    Movie(id: "tt0110912",
          title: "Pulp Fiction",
          imageUrl: "https://m.media-amazon.com/images/M/MV5BNGNhMDIzZTUtNTBlZi00MTRlLWFjM2ItYzViMjE3YzI5MjljXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg")]

let MOVIES = [
    Movie(id: "tt0082971",
          title: "Raiders of the Lost Ark",
          imageUrl: "https://m.media-amazon.com/images/M/MV5BMjA0ODEzMTc1Nl5BMl5BanBnXkFtZTcwODM2MjAxNA@@._V1_SX300.jpg",
          imdbRating: "8.4"),
    Movie(id: "tt0088763",
          title: "Back to the Future",
          imageUrl: "https://m.media-amazon.com/images/M/MV5BZmU0M2Y1OGUtZjIxNi00ZjBkLTg1MjgtOWIyNThiZWIwYjRiXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg"),
    Movie(id: "tt0110912",
          title: "Pulp Fiction",
          imageUrl: "https://m.media-amazon.com/images/M/MV5BNGNhMDIzZTUtNTBlZi00MTRlLWFjM2ItYzViMjE3YzI5MjljXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg"),
    Movie(id: "tt0120737",
          title: "The Lord of the Rings: The Fellowship of the Ring",
          imageUrl: "https://m.media-amazon.com/images/M/MV5BN2EyZjM3NzUtNWUzMi00MTgxLWI0NTctMzY4M2VlOTdjZWRiXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_SX300.jpg"),
    Movie(id: "tt0137523",
          title: "Fight Club",
          imageUrl: "https://m.media-amazon.com/images/M/MV5BMmEzNTkxYjQtZTc0MC00YTVjLTg5ZTEtZWMwOWVlYzY0NWIwXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg"),
]
