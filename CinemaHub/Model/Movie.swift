//
//  Movie.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/21.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Movie  {
    var posterPath: String
    var videoPath: String?
    var title: String
    var releaseDate: String
    var rating: Int
    var overview: String
    
    init(fromJson json: JSON!){
        posterPath = json["poster_path"].stringValue
        title = json["title"].stringValue
        releaseDate = json["release_date"].stringValue
        rating = Int(json["vote_average"].doubleValue) / 2
        overview = json["overview"].stringValue
    }
}
