//
//  MovieApi.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/28.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import Foundation
import Moya

enum MovieApi {
    case topRated(page:Int, key: String)
    case newMovies(page:Int, key: String)
}

extension MovieApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/movie/")!
    }
    
    var path: String {
        switch self {
        case .topRated:
            return "popular"
        case .newMovies:
            return "now_playing"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .topRated, .newMovies:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .topRated(let page, let key), .newMovies(let page, let key):
            return ["page": page, "api_key": key]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .topRated, .newMovies:
            return URLEncoding.queryString
        }
    }
    
    // TO-DO: add sample data for tests
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .topRated, .newMovies:
            return .request
        }
    }
    
    
}
