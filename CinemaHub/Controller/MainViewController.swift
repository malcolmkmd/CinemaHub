//
//  MainViewController.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/19.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import UIKit
import Pastel
import SwiftIcons

enum Showing {
    case opened
    case closed
    
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var gradientView: PastelView!
    @IBOutlet weak var searchBorderView: UIView!
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var topCVC: UICollectionView!
    @IBOutlet weak var bottomCVC: UICollectionView!
    @IBOutlet weak var showAllTopBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var topHalf: UIView!
    @IBOutlet weak var bottomHalf: UIView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    var state: Showing = .closed
    
    var toplayout: UICollectionViewFlowLayout!
    var bottomlayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        state = .closed
        toplayout = topCVC.collectionViewLayout as? UICollectionViewFlowLayout
        bottomlayout = bottomCVC.collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupGradientView()
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
        searchBorderView.layer.shadowRadius = 3
        searchBorderView.layer.shadowOpacity = 0.4
        searchBorderView.layer.shadowOffset = CGSize(width: 1, height: 2)
        searchIcon.image  = UIImage.init(icon: .ionicons(.iosSearchStrong), size: CGSize(width: 30, height: 30), textColor: .flatWhite())
        searchBorderView.isHidden = true
    }
    
    func setupGradientView(){
        gradientView.startPastelPoint = .bottomLeft
        gradientView.endPastelPoint = .topRight
        gradientView.animationDuration = 500.0
        gradientView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                                UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                                UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                                UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0)])
        
        gradientView.startAnimation()
    }
    
    func setupCVC(){
        let cellScaling: CGFloat = 0.7
        let cellWidth = CGFloat(40)
        let cellHeightTop = floor((topCVC.frame.height/2) * cellScaling)
        let cellHeightBottom = floor((bottomCVC.frame.height/2) * cellScaling)
        let insetX = CGFloat(10)
        let insetY = CGFloat(0)
        topCVC.clipsToBounds = true
        bottomCVC.clipsToBounds = true
        
        toplayout?.itemSize = CGSize(width: cellWidth, height: cellHeightTop)
        topCVC.contentInset = UIEdgeInsets(top: CGFloat(insetY), left: insetX, bottom: 0, right: insetX)
        toplayout.minimumInteritemSpacing = 0
        toplayout.minimumLineSpacing = 0
        
        bottomlayout?.itemSize = CGSize(width: cellWidth, height: cellHeightBottom)
        bottomCVC.contentInset = UIEdgeInsets(top: CGFloat(insetY), left: insetX, bottom: 0, right: insetX)
        bottomlayout.minimumInteritemSpacing = 0
        bottomlayout.minimumLineSpacing = 0
        
        topCVC.register(UINib(nibName: "TopMovieCell", bundle: Bundle.main), forCellWithReuseIdentifier: "topCell")
        bottomCVC.register(UINib(nibName: "BottomMovieCell", bundle: Bundle.main), forCellWithReuseIdentifier: "bottomCell")
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    @IBAction func showAllTop(_ sender: Any) {
        switch state {
        case .opened:
            showAllTopBtn.setTitle("SEE ALL", for: .normal)
            self.stackView.removeArrangedSubview(self.topHalf)
            UIView.animate(withDuration: 2, animations: {
                self.bottomHalf.isHidden = false
                self.stackView.addArrangedSubview(self.topHalf)
                self.stackView.addArrangedSubview(self.bottomHalf)
                self.toplayout.scrollDirection = .horizontal
                self.searchBorderView.isHidden = true
            })
            state = .closed
            break
        case .closed:
            showAllTopBtn.setTitle("CLOSE", for: .normal)
            
            UIView.animate(withDuration: 2, animations: {
                self.stackView.removeArrangedSubview(self.bottomHalf)
                self.bottomHalf.isHidden = true
                self.toplayout.scrollDirection = .vertical
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topCVC {
            switch state {
            case .closed:
                return CGSize(width: 165, height: self.topCVC.frame.height)
            case .opened:
                return CGSize(width: 170, height: self.topCVC.frame.height)
            }
        }else {
            return CGSize(width: 165, height: self.bottomCVC.frame.height)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
