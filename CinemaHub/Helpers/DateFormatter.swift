//
//  DateFormatter.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/07/03.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import Foundation

class DF {
    static let instance = DateFormatter()
    
    static func format(date: String) -> String {
        instance.dateFormat = "yyyy-MM-dd"
        guard let date = instance.date(from: date) else { fatalError("could not format date") }
        instance.dateFormat = "MMM, dd"
        return instance.string(from: date)
    }
}
