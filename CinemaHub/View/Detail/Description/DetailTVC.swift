//
//  DetailTVC.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/27.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DetailTVC: UITableViewController {
    
    var overview: String!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DescriptionCell", bundle: Bundle.main), forCellReuseIdentifier: "descriptionCell")
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.allowsSelection = false 
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as? DescriptionCell {
            cell.overview = overview
            return cell
        }else {
            return UITableViewCell()
        }
    }
}

extension DetailTVC: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Description")
    }
}



