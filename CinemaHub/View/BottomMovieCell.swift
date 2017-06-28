//
//  BottomMovieCell.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/20.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import UIKit
import Kingfisher

class BottomMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI(){
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie!.posterPath)")!
        let resource = ImageResource(downloadURL: url, cacheKey: movie?.title)
        posterImage.kf.setImage(with: resource, placeholder: #imageLiteral(resourceName: "placer"), options: [.transition(.fade(0.3))])
        titleLabel.text = movie?.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let date = dateFormatter.date(from: (movie?.releaseDate)!)!
        dateFormatter.dateFormat = "MMM, dd"
        dateLabel.text = dateFormatter.string(from: date)
    }
}
