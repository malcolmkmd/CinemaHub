//
//  MainViewController.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/19.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import UIKit
import Hero
import SwiftIcons

enum Showing {
    case opened
    case closed
    
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchBorderView: UIView!
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var bottomCVC: UICollectionView!
    @IBOutlet weak var topCVC: UICollectionView!
    @IBOutlet weak var showAllTopBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var topHalf: UIView!
    @IBOutlet weak var bottomHalf: UIView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var showButtonHeight: NSLayoutConstraint!
    
    var cellWidth: CGFloat!
    var state: Showing = .closed
    var bottomlayout: UICollectionViewFlowLayout!
    var toplayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        state = .closed
        bottomlayout = bottomCVC.collectionViewLayout as? UICollectionViewFlowLayout
        toplayout = topCVC.collectionViewLayout as? UICollectionViewFlowLayout
        cellWidth = (UIScreen.main.bounds.width/2) - 16
        showAllTopBtn.setIcon(icon: .linearIcons(.chevronDown), color: UIColor.flatRed(), forState: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
        setupSearch()
        setupCVC()
    }
    
    func setupNavBar(){
        NavHelper.configureNavBar(on: self, leftButtonAction: "DoStuff")
    }
    
    func setupSearch(){
        searchBorderView.backgroundColor = UIColor.white
        searchBorderView.layer.borderColor = UIColor.clear.cgColor
        searchBorderView.layer.borderWidth = 1
        searchBorderView.layer.cornerRadius = 14
        searchBorderView.layer.shadowRadius = 2
        searchBorderView.layer.shadowOpacity = 0.4
        searchBorderView.layer.shadowOffset = CGSize(width: 1, height: 2)
        searchIcon.image  = UIImage.init(icon: .ionicons(.iosSearchStrong), size: CGSize(width: 30, height: 30), textColor: .flatWhite())
        searchBorderView.isHidden = true
    }
    
    func setupCVC(){
        
        let insetX = CGFloat(10)
        let insetY = CGFloat(0)
        topCVC.clipsToBounds = true
        bottomCVC.clipsToBounds = true
        
        topCVC.contentInset = UIEdgeInsets(top: CGFloat(insetY), left: insetX, bottom: 0, right: insetX)
        bottomCVC.contentInset = UIEdgeInsets(top: CGFloat(insetY), left: insetX, bottom: 0, right: insetX)
        
        topCVC.register(UINib(nibName: "TopMovieCell", bundle: Bundle.main), forCellWithReuseIdentifier: "topCell")
        bottomCVC.register(UINib(nibName: "BottomMovieCell", bundle: Bundle.main), forCellWithReuseIdentifier: "bottomCell")
        
    }
    
    @IBAction func showAllTop(_ sender: Any) {
        switch state {
        case .opened:
            self.stackView.removeArrangedSubview(self.bottomHalf)
            showAllTopBtn.setIcon(icon: .linearIcons(.chevronDown), color: UIColor.flatRed(), forState: .normal)
            UIView.animate(withDuration: 0.3, animations: {
                self.topHalf.isHidden = false
                self.stackView.addArrangedSubview(self.topHalf)
                self.stackView.addArrangedSubview(self.bottomHalf)
                self.bottomlayout.scrollDirection = .horizontal
                self.searchBorderView.isHidden = true
                self.setupCVC()
            })
            
            self.topCVC.setNeedsDisplay()
            state = .closed
            break
        case .closed:
            showAllTopBtn.setIcon(icon: .linearIcons(.crossCircle), color: UIColor.flatRed(), forState: .normal)
            UIView.animate(withDuration: 2, animations: {
                self.stackView.removeArrangedSubview(self.topHalf)
                self.topHalf.isHidden = true
                self.bottomlayout.scrollDirection = .vertical
                self.searchBorderView.isHidden = false
            })
            state = .opened
            break
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topCVC {
            let cell = topCVC.dequeueReusableCell(withReuseIdentifier: "topCell", for: indexPath)
            return cell
        }else if collectionView == bottomCVC {
            let cell = bottomCVC.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath)
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCVC {
            return 1
        }else if collectionView == bottomCVC {
            return 5
        }else{
            return 0 
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "detailVC") as? DetailViewController {
            detailVC.movie = Movie(name: "Black Panthers")
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if state == .opened{
//            UIView.animate(withDuration: 0.3, animations: {
//                self.showButtonHeight.constant = 0
//            })
//        }
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topCVC {
            switch state {
            case .closed:
                return CGSize(width: 160, height: self.topCVC.frame.height)
            case .opened:
                return CGSize(width: cellWidth, height: self.topCVC.frame.height)
            }
        }else {
            return CGSize(width: cellWidth, height: self.bottomCVC.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
