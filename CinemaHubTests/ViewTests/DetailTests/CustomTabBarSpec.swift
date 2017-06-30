//
//  CustomTabBarSpec.swift
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

class CustomTabBarSpec : QuickSpec {
    override func spec() {
        super.spec()
        let sut = CustomTabBar()
        test_viewDidLoad(view: sut)
        test_viewControllers(view: sut)
        test_changeIndex(view: sut)
    }
    
    func test_viewDidLoad(view sut: CustomTabBar){
        beforeEach {
            sut.overview = "the overview"
            sut.movieID = 1
            sut.viewDidLoad()
        }
        
        it("should set id and overview"){
            expect(sut.overview).to(equal("the overview"))
            expect(sut.movieID).to(equal(1))
        }
        
        it("should style"){
            expect(sut.settings.style.selectedBarHeight).to(equal(1))
            expect(sut.settings.style.selectedBarBackgroundColor).to(equal(sut.selectedColor))
            expect(sut.settings.style.buttonBarItemBackgroundColor).to(equal(UIColor.clear))
            expect(sut.settings.style.buttonBarBackgroundColor).to(equal(UIColor.white))
            expect(sut.settings.style.buttonBarMinimumLineSpacing).to(equal(0))
            expect(sut.settings.style.buttonBarItemTitleColor).to(equal(UIColor.lightGray))
        }
    }
    
    func test_viewControllers(view sut: CustomTabBar){
        beforeEach {
            sut.viewDidLoad()
        }
        
        it("should set viewControllers"){
            expect(sut.viewControllers(for: sut)[0]).to(beAKindOf(DetailTVC.self))
            expect(sut.viewControllers(for: sut)[1]).to(beAKindOf(RecomendationsTVC.self))
        }
    }
    
    func test_changeIndex(view sut: CustomTabBar){
        beforeEach {
            sut.viewDidLoad()
        }
        
        it(""){
        }
    }
}
