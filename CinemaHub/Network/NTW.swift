//
//  API.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/28.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import Foundation
import Moya
class NTW {
    static let Api: NTW = {
        let instance = NTW()
        return instance
    }()
    
    static let Key = "7a312711d0d45c9da658b9206f3851dd"
    let provider = MoyaProvider<MovieApi>()
    
    func getNewMovies(page: Int) {
        Api.provider.request(MovieApi.newMovies(page: page, key: NTW.Key)) { result in
            switch result {
            case let .success(response):
                do {
                    let data = try response.mapJSON()
                    print(data)
                }catch {
                    
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
