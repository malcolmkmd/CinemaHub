//
//  CustomTabBar.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/27.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class CustomTabBar: ButtonBarPagerTabStripViewController {
    
    let selectedColor = UIColor.flatGreenColorDark()
    
    let tabOne = DetailTVC()
    let tabTwo = RecomendationsTVC()
    
    var overview: String!
    var movieID: Int!
    
    override func viewDidLoad() {
        style()
        tabOne.overview = overview
        tabTwo.movieID = movieID

        super.viewDidLoad()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [tabOne, tabTwo]
    }
    
    func style(){
        settings.style.selectedBarHeight = 1
        settings.style.selectedBarBackgroundColor = selectedColor!
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .lightGray
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .lightGray
            newCell?.label.textColor = self?.selectedColor
        }
    }
}
