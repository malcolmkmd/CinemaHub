//
//  Helper.swift
//  CinemaHubTests
//
//  Created by Malcolm Kumwenda on 2017/07/03.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import Foundation
@testable import CinemaHub

class Helper {
    
    static func getMovies() -> [Movie]?{
        if let path = Bundle(for: self).url(forResource: "Movies", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: path)
                let results = try JSONDecoder().decode(APIResults.self, from: jsonData)
                return results.movies
            }catch let err {
                print(err)
            }
        }
        return nil
    }
    
    static func getMovie() -> Movie?{
        if let path = Bundle(for: self).url(forResource: "Movies", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: path)
                let results = try JSONDecoder().decode(APIResults.self, from: jsonData)
                return results.movies[0]
            }catch let err {
                print(err)
            }
        }
        return nil
    }
}
