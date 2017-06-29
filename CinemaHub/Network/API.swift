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
    static let provider = MoyaProvider<MovieApi>(plugins: [NetworkLoggerPlugin(verbose: true)]) 
    
    static func getNewMovies(page: Int, completion: @escaping ([Movie])->()){
        provider.request(.newMovies(page: page)) { result in
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
    
    static func getTopRated(page: Int, completion: @escaping ([Movie?])->()){
        provider.request(.topRated(page: page)) { result in
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
    
    static func getRecommendations(forMovieWith id: Int, completion: @escaping ([Movie]?)->()){
        provider.request(.reco(id: id)) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
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
    
    static func getVideo(forMovieWith id: Int, completion: @escaping (String?)->()){
        provider.request(.video(id: id)){ result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                let results = json["results"].arrayValue
                let url = results[0]["key"].stringValue
                completion(url)
            case let .failure(error):
                print(error)
            }
            
        }
    }
    
}
