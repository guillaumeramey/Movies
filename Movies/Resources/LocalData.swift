//
//  UserData.swift
//  Movies
//
//  Created by Guillaume Ramey on 14/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import Foundation

let movieData: OmdbMovie = load("MovieData.json")
let movieSearchData: [OmdbMovie] = load("MovieSearchData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
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

//let mIronman = Movie(id: "tt0371746",
//                    title: "Iron Man",
//                    imageUrl: "https://m.media-amazon.com/images/M/MV5BMTczNTI2ODUwOF5BMl5BanBnXkFtZTcwMTU0NTIzMw@@._V1_UX182_CR0,0,182,268_AL_.jpg",
//                    year: "2008",
//                    genre: "Action, Adventure, Sci-Fi")
//
//
//let mIronman2 = Movie(id: "tt1228705",
//                    title: "Iron Man 2",
//                    imageUrl: "https://m.media-amazon.com/images/M/MV5BMTM0MDgwNjMyMl5BMl5BanBnXkFtZTcwNTg3NzAzMw@@._V1_UX182_CR0,0,182,268_AL_.jpg",
//                    year: "2010",
//                    genre: "Action, Adventure, Sci-Fi")
//
//let Inception = Movie(id: "tt1375666",
//                      title: "Inception",
//                      imageUrl: "https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg",
//                      year: "2010",
//                      genre: "Action, Adventure, Sci-Fi, Thriller")
//
//let PulpFiction = Movie(id: "tt0110912",
//                        title: "Pulp Fiction",
//                        imageUrl: "https://m.media-amazon.com/images/M/MV5BNGNhMDIzZTUtNTBlZi00MTRlLWFjM2ItYzViMjE3YzI5MjljXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg",
//                        year: "1994",
//                        genre: "Crime, Drama")
//
//let RaidersOfTheLostArk = Movie(id: "tt0082971",
//                                title: "Raiders of the Lost Ark",
//                                imageUrl: "https://m.media-amazon.com/images/M/MV5BMjA0ODEzMTc1Nl5BMl5BanBnXkFtZTcwODM2MjAxNA@@._V1_SX300.jpg",
//                                year: "1981",
//                                genre: "Action, Adventure")
//
//let BackToTheFuture = Movie(id: "tt0088763",
//                            title: "Back to the Future",
//                            imageUrl: "https://m.media-amazon.com/images/M/MV5BZmU0M2Y1OGUtZjIxNi00ZjBkLTg1MjgtOWIyNThiZWIwYjRiXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg",
//                            year: "1985",
//                            genre: "Action, Comedy, Sci-Fi")
//
//let FightClub = Movie(id: "tt0137523",
//                      title: "Fight Club",
//                      imageUrl: "https://m.media-amazon.com/images/M/MV5BMmEzNTkxYjQtZTc0MC00YTVjLTg5ZTEtZWMwOWVlYzY0NWIwXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg",
//                      year: "1999",
//                      genre: "Drama")
//
//let LOTR1 = Movie(id: "tt0120737",
//                  title: "The Lord of the Rings: The Fellowship of the Ring",
//                  imageUrl: "https://m.media-amazon.com/images/M/MV5BN2EyZjM3NzUtNWUzMi00MTgxLWI0NTctMzY4M2VlOTdjZWRiXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_SX300.jpg",
//                  year: "2001",
//                  genre: "Action, Adventure, Drama, Fantasy")
