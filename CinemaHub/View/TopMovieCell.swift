//
//  TopMovieCell.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/20.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import UIKit
import Kingfisher
import HCSStarRatingView

class TopMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingView: HCSStarRatingView!
    
    var movie: Movie? {
        didSet {
            self.updateUI()
        }
    }
    
   private  func updateUI(){
        guard let movie = movie else { return  }
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")!
        let resource = ImageResource(downloadURL: url, cacheKey: movie.title)
        posterImage.kf.setImage(with: resource, placeholder: #imageLiteral(resourceName: "placer"), options: [.transition(.fade(0.3))])
        titleLabel.text = movie.title
        ratingView.value = CGFloat((movie.rating))/2
        dateLabel.text = DF.format(date: movie.releaseDate)
    }
}
