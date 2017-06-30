//
//  MovieSpec.swift
//  CinemaHubTests
//
//  Created by Malcolm Kumwenda on 2017/06/30.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
import SwiftyJSON
@testable import CinemaHub

class MovieSpec: QuickSpec {
    override func spec(){
        testInit()
    }
    
    func testInit(){
        describe("test model initialization"){
            it("should set from json"){
                guard let json = Helper.getJSON(file: "Movie") else { fatalError("could not serialize json file") }
                let movie = Movie(fromJson: json)
                expect(movie.id).to(equal(374430))
                expect(movie.posterPath).to(equal("/he609rnU3tiwBjRklKNa4n2jQSd.jpg"))
                expect(movie.videoPath).to(beNil())
                expect(movie.backdrop).to(equal("/rMCew7St2vy9iV3QOPzx15sAkFJ.jpg"))
                expect(movie.title).to(equal("Black Mirror: White Christmas"))
                expect(movie.releaseDate).to(equal("Dec, 16"))
                expect(movie.rating).to(equal(4))
                expect(movie.overview).to(equal("This feature-length special consists of three interwoven stories. In a mysterious and remote snowy outpost, Matt and Potter share a Christmas meal, swapping creepy tales of their earlier lives in the outside world. Matt is a charismatic American trying to bring the reserved, secretive Potter out of his shell. But are both men who they appear to be? A woman gets thrust into a nightmarish world of 'smart' gadgetry. Plus a look at what would happen if you could 'block' people in real life."))
            }
        }
    }
}
