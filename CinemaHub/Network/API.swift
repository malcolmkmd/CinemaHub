//
//  API.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/28.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import Foundation
import Moya
import YoutubeSourceParserKit

class API {
    
    static let apiKey = movieAPIkey
    static let provider = MoyaProvider<MovieApi>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    static func getNewMovies(page: Int, completion: @escaping ([Movie])->()){
        provider.request(.newMovies(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(APIResults.self, from: response.data)
                    completion(results.movies)
                }catch let err{
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func getTopRated(page: Int, completion: @escaping ([Movie?])->()){
        provider.request(.topRated(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(APIResults.self, from: response.data)
                    completion(results.movies)
                }catch let err{
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func getRecommendations(forMovieWith id: Int, completion: @escaping ([Movie]?)->()){
        provider.request(.reco(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(APIResults.self, from: response.data)
                    completion(results.movies)
                }catch let err{
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func getVideo(forMovieWith id: Int, completion: @escaping (String?)->()){
        provider.request(.video(id: id)){ result in
            switch result {
            case let .success(response):
                do {
                    let videos = try JSONDecoder().decode(VideoResults.self, from: response.data)
                    guard let videoURL = URL(string: "https://www.youtube.com/watch?v=\(videos.details[0].key)") else {return}
                    Youtube.h264videosWithYoutubeURL(videoURL) { videoInfo, error in
                        if let videoURLString = videoInfo?["url"] as? String {
                            completion(videoURLString)
                        }else{
                            guard let placeHolderUrl = URL(string: "https://www.youtube.com/watch?v=NpEaa2P7qZI") else {return}
                            Youtube.h264videosWithYoutubeURL(placeHolderUrl) { videoInfo, error in
                                if let placeHolderVideoUrl = videoInfo?["url"] as? String {
                                    completion(placeHolderVideoUrl)
                                }
                            }
                        }
                    }
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
}
