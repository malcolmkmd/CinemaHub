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
    var id:Int!
    var posterPath: String
    var videoPath: String?
    var backdrop: String
    var title: String
    var releaseDate: String
    var rating: Int
    var overview: String
    
    init(fromJson json: JSON!){
        id = json["id"].intValue
        posterPath = json["poster_path"].stringValue
        title = json["title"].stringValue
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: (json["release_date"].stringValue))!
        dateFormatter.dateFormat = "MMM, dd"
        releaseDate = dateFormatter.string(from: date)
        
        rating = Int(json["vote_average"].doubleValue) / 2
        overview = json["overview"].stringValue
        backdrop = json["backdrop_path"].stringValue
    }
}
