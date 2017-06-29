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
    case reco(id:Int)
    case topRated(page:Int)
    case newMovies(page:Int)
    case video(id:Int)
}

extension MovieApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/movie/")!
    }
    
    var path: String {
        switch self {
        case .reco(let id):
            return "\(id)/recommendations"
        case .topRated:
            return "popular"
        case .newMovies:
            return "now_playing"
        case .video(let id):
            return "\(id)/videos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .reco, .topRated, .newMovies, .video:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .reco, .video:
            return ["api_key": API.apiKey]
        case .topRated(let page), .newMovies(let page):
            return ["page": page, "api_key": API.apiKey]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .reco, .topRated, .newMovies, .video:
            return URLEncoding.queryString
        }
    }
    
    var task: Task {
        switch self {
        case .reco, .topRated, .newMovies, .video:
            return .request
        }
    }
}
