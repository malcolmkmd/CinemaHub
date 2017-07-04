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
        
        // setup
        let sut = DetailTVC()
        sut.overview = "the overview"
        sut.viewDidLoad()
        
        test_viewDidLoad(sut)
        test_tableViewDelegates(sut)
        test_indicatorInfo(sut)
        test_descriptionCell(sut)
    }
    
    func test_viewDidLoad(_ sut: DetailTVC){
        describe("test viewDidLoad") {
            it("should init the tableView"){
                expect(sut.tableView.separatorStyle).to(equal(UITableViewCellSeparatorStyle.none))
                expect(sut.tableView.bounces).to(beFalse())
                expect(sut.tableView.estimatedRowHeight).to(equal(80))
                expect(sut.tableView.allowsSelection).to(beFalse())
                expect(sut.tableView.rowHeight).to(equal(UITableViewAutomaticDimension))
            }
        }
    }
    
    func test_tableViewDelegates(_ sut: DetailTVC){
        describe("it should set all delegate methods"){
            
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
    
    func test_indicatorInfo(_ sut: DetailTVC){
        describe("test indicatorInfo"){
            let info = sut.indicatorInfo(for: PagerTabStripViewController())
            expect(info.title).to(equal("Description"))
        }
    }
    
    func test_descriptionCell(_ view: DetailTVC){
        describe("test descriptionCell"){
            it("should set overlabel view text"){
                if let cell = view.tableView(view.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? DescriptionCell {
                    expect(cell.overviewLabel.text).to(equal(view.overview))
                }
            }
        }
    }
}
