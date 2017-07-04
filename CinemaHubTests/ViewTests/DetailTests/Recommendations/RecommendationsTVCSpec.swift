//
//  RecommendationsSpec.swift
//  CinemaHubTests
//
//  Created by Malcolm Kumwenda on 2017/07/04.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay
@testable import CinemaHub

class RecommendationsSpec : QuickSpec {
    override func spec() {
        super.spec()
        let sut = RecomendationsTVC()
        sut.movieID = 5274
        test_viewDidLoad(sut)
    }
    
    func test_viewDidLoad(_ sut:RecomendationsTVC){
        describe("test gets recommendations"){
            beforeEach {
                sut.viewDidLoad()
            }
            
            it("should get recommendations"){
                expect(sut.movies.isEmpty).toEventually(beFalse())
            }
        }
    }
}


