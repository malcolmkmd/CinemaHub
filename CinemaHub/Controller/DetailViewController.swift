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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let detailTabs = CustomTabBar()
    
    var movie: Movie! {
        didSet {
            self.updateUI()
        }
    }
    var player: BMPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        API.getVideo(forMovieWith: (movie.id)!){ url in
            self.movie?.videoPath = url
            self.setupPlayer()
            
        }
        
        // Setup video player configurations
        BMPlayerConf.shouldAutoPlay = false
        BMPlayerConf.topBarShowInCase = .always
        
        detailTabs.view.frame = tabbarPagerView.bounds
        tabbarPagerView.addSubview(detailTabs.view)
        titleLabel.text = movie.title
        releaseLabel.text = "Release: \(movie.releaseDate)"
        rating.value = CGFloat((movie.rating))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          self.spinner.startAnimating()
    }
    
    func setupPlayer(){
        guard let videoPath = movie.videoPath else {return}
        guard let videoURL = URL(string: videoPath), let cover = URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdrop)") else {return}
        let video = BMPlayerResource(url: videoURL, name: movie.title, cover: cover, subtitle: nil)
        let customController = BMPlayerCustomControlView()
        
        player = BMPlayer(customControlView: BMPlayerCustomControlView())
        player.setVideo(resource: video)
        
        
        player.backBlock = { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        
        DispatchQueue.main.async {
            self.videoView.addSubview(self.player)
            self.spinner.stopAnimating()
            self.player.snp.makeConstraints { make in
                make.top.equalTo(self.videoView)
                make.left.right.equalTo(self.videoView)
                make.height.equalTo(self.videoView.frame.height)
            }
        }
    }
    
    func updateUI(){
        detailTabs.overview = movie?.overview
        detailTabs.movieID = movie?.id
        detailTabs.pushDelegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.pause()
    }
    
    deinit {
        player.prepareToDealloc()
    }
}

extension DetailViewController: PushDelegate{
    func push(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
