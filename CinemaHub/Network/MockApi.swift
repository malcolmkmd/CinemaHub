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
        return Data()
    }
    
    func stubbedResponse(_ filename: String) -> Data! {
        @objc class TestClass: NSObject { }
        
        let bundle = Bundle(for: TestClass.self)
        let path = bundle.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }

}
