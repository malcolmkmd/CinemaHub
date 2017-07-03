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
        guard let movie = movie else { fatalError("Trying to updateUI with no movie") }
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") else { fatalError("Could not get movie poster path")}
        let resource = ImageResource(downloadURL: url, cacheKey: movie.title)
        posterImage.kf.setImage(with: resource, placeholder: #imageLiteral(resourceName: "placer"), options: [.transition(.fade(0.3))])
        titleLabel.text = movie.title
        dateLabel.text = DF.format(date: movie.releaseDate)
    }
}
