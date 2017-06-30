//
//  DetailTVCSpec.swift
//  CinemaHubTests
//
//  Created by Malcolm Kumwenda on 2017/06/30.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay
import XLPagerTabStrip
@testable import CinemaHub

class DetailTVCSpec : QuickSpec {
    override func spec() {
        super.spec()
        let sut = DetailTVC()
        sut.overview = "the overview"
        test_viewDidLoad(view: sut)
        test_tableViewDelegates(view: sut)
        test_indicatorInfo(view: sut)
    }
    
    func test_viewDidLoad(view sut: DetailTVC){
        describe("test viewDidLoad") {
            beforeEach {
                sut.viewDidLoad()
            }
            
            it("should init the tableView"){
                expect(sut.tableView.separatorStyle).to(equal(UITableViewCellSeparatorStyle.none))
                expect(sut.tableView.bounces).to(beFalse())
                expect(sut.tableView.estimatedRowHeight).to(equal(80))
                expect(sut.tableView.allowsSelection).to(beFalse())
                expect(sut.tableView.rowHeight).to(equal(UITableViewAutomaticDimension))
            }
        }
    }
    
    func test_tableViewDelegates(view sut: DetailTVC){
        describe("it should set all delegate methods"){
            beforeEach {
                sut.viewDidLoad()
            }
            
            it("should set numberOfSections"){
                expect(sut.numberOfSections(in: sut.tableView)).to(equal(1))
            }
            
            it("should set numberOfRowsInSection"){
                expect(sut.tableView(sut.tableView, numberOfRowsInSection: 0)).to(equal(1))
            }
            
            context("descriptionCell"){
                it("should set cellForRowAt"){
                    expect(sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))).to(beAKindOf(DescriptionCell.self))
                }
            }
            
            context("unknown cell"){
                it("should set cellForRowAt"){
                    expect(sut.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 0))).to(beAKindOf(UITableViewCell.self))
                }
            }
        }
    }
    
    func test_indicatorInfo(view sut: DetailTVC){
        describe("test indicatorInfo"){
            let info = sut.indicatorInfo(for: PagerTabStripViewController())
            expect(info.title).to(equal("Description"))
        }
    }
}
