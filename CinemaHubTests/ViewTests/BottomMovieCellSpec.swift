//
//  BottomMovieCellSpec.swift
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

class BottomMovieCellSpec : QuickSpec {
    override func spec() {
        super.spec()
        
        guard let sut = UINib(nibName: "BottomMovieCell", bundle: Bundle.main).instantiate(withOwner: nil, options: nil).first as? BottomMovieCell else {fatalError("could not initailize nib BottomMovieCell")}
        it("checks view controller is not nil"){
            expect(sut).toNot(beNil())
        }
        
        testOutlets(view: sut)
        test_updateUI(view: sut)
    }
    
    func testOutlets(view sut:BottomMovieCell){
        describe("test all outlets are connected") {
            beforeEach {
                sut.awakeFromNib()
            }
            
            it("should have no nil outlets"){
                expect(sut.posterImage).toNot(beNil())
                expect(sut.titleLabel).toNot(beNil())
                expect(sut.dateLabel).toNot(beNil())
            }
        }
    }
    
    func test_updateUI(view sut: BottomMovieCell){
        describe("test UI update"){
            beforeEach {
                guard let json = Helper.getJSON(file: "Movie") else { fatalError("could not serialize json file") }
                sut.movie = Movie(fromJson: json)
            }
            
            it("should set movie details"){
                expect(sut.titleLabel.text).to(equal("Black Mirror: White Christmas"))
                expect(sut.dateLabel.text).to(equal("Dec, 16"))
                expect(sut.posterImage.image).toNot(beNil())
            }
        }
    }
}

