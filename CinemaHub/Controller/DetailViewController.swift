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
import YoutubeSourceParserKit

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
        
        
        var key = ""
        var videoURL = URL(string: "https://www.youtube.com/watch?")!
        let videoTitle = movie?.title
        API.getVideo(forMovieWith: (movie?.id)!) { url in
            key = url!
            videoURL = URL(string: "https://www.youtube.com/watch?v=\(key)")!
            Youtube.h264videosWithYoutubeURL(videoURL) { videoInfo, error in
                if let videoURLString = videoInfo?["url"] as? String {
                    videoURL =  URL(string: videoURLString)!
                    let video = BMPlayerResource(url: videoURL, name: videoTitle!, cover: URL(string: "https://image.tmdb.org/t/p/w500\(self.movie!.backdrop)"), subtitle: nil)
                    self.player = BMPlayer(customControlView: BMPlayerCustomControlView())
                    self.player.setVideo(resource: video)
                    
                    DispatchQueue.main.async {
                         self.videoView.addSubview(self.player)
                        
                        self.player.snp.makeConstraints { (make) in
                            make.top.equalTo(self.videoView)
                            make.left.right.equalTo(self.videoView)
                            make.height.equalTo(self.player.snp.width).multipliedBy(9.0/16.0).priority(750)
                        }
                        
                        self.player.backBlock = { _ in
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
        
        detailTabs.view.frame = tabbarPagerView.bounds
        
        tabbarPagerView.addSubview(detailTabs.view)
        
        titleLabel.text = movie?.title
        releaseLabel.text = "Release: \(movie?.releaseDate ?? "")"
        rating.value = CGFloat((movie?.rating)!)
    }
    
    func updateUI(){
        detailTabs.overview = movie?.overview
        detailTabs.movieID = movie?.id
        detailTabs.pushDelegate = self
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

extension DetailViewController: PushDelegate{
    func push(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
