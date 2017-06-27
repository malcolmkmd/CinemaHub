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
    
    let selectedColor = UIColor(hexString: "424065")!
    
    override func viewDidLoad() {
        style()
        
        super.viewDidLoad()
    }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [DetailTVC(), CastTVC()]
    }
    
    func style(){
        settings.style.selectedBarHeight = 1
        settings.style.selectedBarBackgroundColor = selectedColor
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
