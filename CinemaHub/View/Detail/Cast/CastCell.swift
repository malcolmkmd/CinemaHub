//
//  CastCell.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/27.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import UIKit

class CastCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImg.layer.cornerRadius = 25
        profileImg.clipsToBounds = true 
    }
}
