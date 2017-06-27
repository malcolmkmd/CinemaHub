//
//  DetailViewController.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/21.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import UIKit
import BMPlayer

class DetailViewController: UIViewController {

    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var tabbarPagerView: UIView!
    
    let detailTabs = CustomTabBar()
    
    var movie: Movie!
    var player: BMPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup video player
        BMPlayerConf.shouldAutoPlay = false
        BMPlayerConf.topBarShowInCase = .always
        let videoURL = URL(string: "http://player.vimeo.com/external/85569724.sd.mp4?s=43df5df0d733011263687d20a47557e4")!
        let videoTitle = "Star Wars: Episode VII3"
        let video = BMPlayerResource(url: videoURL, name: videoTitle, cover: URL(string: "https://cdn.pixabay.com/photo/2017/05/18/21/54/tower-bridge-2324875_960_720.jpg"), subtitle: nil)
        player = BMPlayer(customControlView: BMPlayerCustomControlView())
        player.setVideo(resource: video)

        player.frame = videoView.bounds
        videoView.addSubview(player)
        player.backBlock = { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        detailTabs.view.frame = tabbarPagerView.bounds
        tabbarPagerView.addSubview(detailTabs.view)
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
