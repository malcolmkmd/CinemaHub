//
//  MockApi.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/29.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import Foundation


extension MovieApi {
    var sampleData: Data {
        switch self {
        case .reco, .topRated, .newMovies, .video:
            return stubbedResponse("Movies")
        }
    }
    
    func stubbedResponse(_ filename: String) -> Data! {
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else { fatalError("path could not be found") }
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }

}
