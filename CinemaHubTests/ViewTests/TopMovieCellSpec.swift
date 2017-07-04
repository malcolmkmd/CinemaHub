//
//  TopMovieCellSpec.swift
//  CinemaHubTests
//
//  Created by Malcolm Kumwenda on 2017/06/30.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay
@testable import CinemaHub

class TopMovieCellSpec : QuickSpec {
    override func spec() {
        super.spec()
        
        guard let sut = UINib(nibName: "TopMovieCell", bundle: Bundle.main).instantiate(withOwner: nil, options: nil).first as? TopMovieCell else {fatalError("could not initailize nib TopMovieCell")}
        it("checks view controller is not nil"){
            expect(sut).toNot(beNil())
        }
        
        testOutlets(view: sut)
        test_updateUI(view: sut)
    }
    
    func testOutlets(view sut:TopMovieCell){
        describe("test all outlets are connected") {
            beforeEach {
                sut.movie = Helper.getMovie()
            }
            
            it("should have no nil outlets"){
                sut.movie = Helper.getMovie()
                expect(sut.posterImage).toNot(beNil())
                expect(sut.titleLabel).toNot(beNil())
                expect(sut.dateLabel).toNot(beNil())
                expect(sut.ratingView).toNot(beNil())
            }
        }
    }
    
    func test_updateUI(view sut: TopMovieCell){
        describe("test UI update"){
            beforeEach {
                sut.movie = Helper.getMovie()
            }
            
            it("should set movie details"){
                expect(sut.titleLabel.text).to(equal("Black Mirror: White Christmas"))
                expect(sut.ratingView.value).to(equal(4))
                expect(sut.dateLabel.text).to(equal("Dec, 16"))
                expect(sut.posterImage.image).toNot(beNil())
            }
        }
    }
}
