//
//  Helper.swift
//  CinemaHubTests
//
//  Created by Malcolm Kumwenda on 2017/06/30.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import Foundation
import SwiftyJSON

class Helper {
    static func getJSON(file: String)->JSON? {
        if let path = Bundle(for: self).path(forResource: file, ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                return JSON(data: jsonData as Data)
            }
        }
        
        return nil
    }
}
