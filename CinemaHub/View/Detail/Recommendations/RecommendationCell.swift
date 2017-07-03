//
//  RecommendationCell.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/27.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import UIKit
import Kingfisher

class RecommendationCell: UITableViewCell {

    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var movie: Movie! {
        didSet {
            self.updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImg.layer.cornerRadius = 25
        posterImg.clipsToBounds = true
    }
    
    
    func updateUI(){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") else { fatalError("could not get recommendation poster") }
        let resource = ImageResource(downloadURL: url, cacheKey: movie.title)
        posterImg.kf.setImage(with: resource, placeholder: #imageLiteral(resourceName: "placer"), options: [.transition(.fade(0.3))])
        nameLbl.text = movie.title
    }
}
