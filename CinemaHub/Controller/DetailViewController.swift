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
    
    var movie: Movie! {
        didSet {
            self.updateUI()
        }
    }
    
    var player: BMPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup video player configurations
        BMPlayerConf.shouldAutoPlay = false
        BMPlayerConf.topBarShowInCase = .always
        
        setupPlayer()
        
        API.getVideo(forMovieWith: movie.id){ url in
            guard let url = url else { fatalError("Could not get video url") }
            guard let video = URL(string: url), let cover = URL(string: "https://image.tmdb.org/t/p/w500\(self.movie.backdrop)") else {return}
            self.addVideo(videoURL: video, coverURL: cover)
        }
        
        detailTabs.view.frame = tabbarPagerView.bounds
        tabbarPagerView.addSubview(detailTabs.view)
        titleLabel.text = movie.title
        releaseLabel.text = "Release: \(DF.format(date: movie.releaseDate))"
        rating.value = CGFloat((movie.rating))/2
    }
        
    func setupPlayer(){
        player = BMPlayer(customControlView: BMPlayerCustomControlView())
        player.backBlock = { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        self.videoView.addSubview(self.player)
        self.player.snp.makeConstraints { make in
            make.top.equalTo(self.videoView)
            make.left.right.equalTo(self.videoView)
            make.height.equalTo(self.videoView.frame.height)
        }
    }
    
    func addVideo(videoURL: URL, coverURL: URL){
        let video = BMPlayerResource(url: videoURL, name: movie.title, cover: coverURL)
        player.setVideo(resource: video)
    }
    
    func updateUI(){
        detailTabs.overview = movie.overview
        detailTabs.movieID = movie.id
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
