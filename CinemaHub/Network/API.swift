//
//  API.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/28.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

class API {
    
    static let apiKey = "7a312711d0d45c9da658b9206f3851dd"
    static let provider = MoyaProvider<MovieApi>()
    
    static func getTopRated(page: Int, completion: @escaping ([Movie])->()){
        provider.request(.topRated(page: page, key: apiKey)) { result in
            switch result {
            case let .success(response):
                let json =  JSON(response.data)
                let results = json["results"].arrayValue
                
                var movies = [Movie]()
                for movie in results {
                    movies.append(Movie(fromJson: movie))
                }
                
                completion(movies)
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func getNewMovies(page: Int, completion: @escaping ([Movie])->()){
        provider.request(.newMovies(page: page, key: apiKey)) { result in
            switch result {
            case let .success(response):
                let json =  JSON(response.data)
                let results = json["results"].arrayValue
                
                var movies = [Movie]()
                for movie in results {
                    movies.append(Movie(fromJson: movie))
                }
                
                completion(movies)
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    
    
    
}
