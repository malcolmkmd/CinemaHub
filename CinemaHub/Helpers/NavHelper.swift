//
//  NavHelper.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/19.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import UIKit
import Hero
import SwiftIcons
import BonMot
import ChameleonFramework

class NavHelper {
    static func transition(to id:String, in storyboard:String, with transition: HeroDefaultAnimationType, from currentView:UIViewController){
        let toVC = UIStoryboard(name: storyboard, bundle: Bundle.main).instantiateViewController(withIdentifier: id)
        toVC.isHeroEnabled = true
        currentView.navigationController?.heroNavigationAnimationType = transition
        currentView.hero_replaceViewController(with: toVC)
        
    }
    
    enum NavBarType {
        case leftArrowLight
        case leftArrowDark
        case leftWithTitle
        case leftWithTitleLight
        case menu
    }
    
    static func configureNavBar(on currentView: UIViewController, leftButtonAction: String){
        
        let leftButton = UIButton.init(type: .custom)
        let rightButton = UIButton.init(type: .custom)
        
        let CinemaTitleview = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        label.textAlignment = .center
        
        leftButton.setImage(UIImage.init(icon: .dripicon(.arrowThinLeft), size: CGSize(width: 35, height: 35), textColor:.flatNavyBlue()), for: UIControlState.normal)
        leftButton.setImage(UIImage.init(icon: .dripicon(.arrowThinLeft), size: CGSize(width: 35, height: 35), textColor:.flatNavyBlue()), for: UIControlState.normal)
        let grayStyle = StringStyle(.color(UIColor("4B4F63")))
        let grayBoldStyle = StringStyle(.color(UIColor("4B4F63")),.font(UIFont(name: "Futura-Bold", size: 17)!))
        let vopStyle = StringStyle(
            .xmlRules([
                .style("gray", grayStyle),
                .style("grayBold", grayBoldStyle)
                ])
        )
        label.attributedText = "<grayBold>CinemaHub</grayBold>".styled(with: vopStyle)
        CinemaTitleview.addSubview(label)
        currentView.navigationItem.titleView = CinemaTitleview
        currentView.navigationController?.isNavigationBarHidden = true
    }
}
