//
//  DetailViewController.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/21.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import UIKit
import BMPlayer
import HCSStarRatingView

class DetailViewController: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var tabbarPagerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var rating: HCSStarRatingView!
    
    let detailTabs = CustomTabBar()
    
    var movie: Movie? {
        didSet {
            self.updateUI()
        }
    }
    var player: BMPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup video player
        BMPlayerConf.shouldAutoPlay = false
        BMPlayerConf.topBarShowInCase = .always
        let videoURL = URL(string: "http://player.vimeo.com/external/85569724.sd.mp4?s=43df5df0d733011263687d20a47557e4")!
        let videoTitle = movie?.title
        let video = BMPlayerResource(url: videoURL, name: videoTitle!, cover: URL(string: "https://image.tmdb.org/t/p/w500\(movie!.backdrop)"), subtitle: nil)
        player = BMPlayer(customControlView: BMPlayerCustomControlView())
        player.setVideo(resource: video)
        
        videoView.addSubview(player)

        player.snp.makeConstraints { (make) in
            make.top.equalTo(videoView)
            make.left.right.equalTo(videoView)
            // Note here, the aspect ratio 16:9 priority is lower than 1000 on the line, because the 4S iPhone aspect ratio is not 16:9
            make.height.equalTo(player.snp.width).multipliedBy(9.0/16.0).priority(750)
        }
        
        player.backBlock = { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        detailTabs.view.frame = tabbarPagerView.bounds
        tabbarPagerView.addSubview(detailTabs.view)
        
        titleLabel.text = movie?.title
        releaseLabel.text = "Release: \(movie?.releaseDate ?? "")"
        rating.value = CGFloat((movie?.rating)!)
    }
    
    func updateUI(){
        detailTabs.overview = movie?.overview
        
    }
}

class BMPlayerCustomControlView: BMPlayerControlView {
    override func controlViewAnimation(isShow: Bool) {
        self.isMaskShowing = isShow
        UIView.animate(withDuration: 0.24, animations: {
            self.topMaskView.snp.remakeConstraints {
                $0.top.equalTo(self.mainMaskView).offset(isShow ? 0 : -65)
                $0.left.right.equalTo(self.mainMaskView).offset(-10)
                $0.height.equalTo(65)
            }
            self.bottomMaskView.snp.remakeConstraints {
                $0.bottom.equalTo(self.mainMaskView).offset(isShow ? 0 : 50)
                $0.left.right.equalTo(self.mainMaskView).offset(-10)
                $0.height.equalTo(50)
            }
            self.layoutIfNeeded()
        }) { (_) in
            self.autoFadeOutControlViewWithAnimation()
        }
    }
}
