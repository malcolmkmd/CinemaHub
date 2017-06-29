//
//  ReccomendationsTVC.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/27.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RecomendationsTVC: UITableViewController {
    
    var movieID: Int!
    var movies: [Movie]!
    var delegate: PushDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movies = [Movie]()
        registerCell()
        getRecommendations()
    }
    
    func getRecommendations(){
        API.getRecommendations(forMovieWith: movieID){ movies in
            guard let movies = movies else {return}
            for movie in movies {
                self.movies.append(movie)
            }
            self.tableView.reloadData()
        }
    }
    
    func registerCell(){
        tableView.register(UINib(nibName: "RecommendationCell", bundle: Bundle.main), forCellReuseIdentifier: "recoCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "recoCell") as? RecommendationCell {
            cell.movie = movies[indexPath.row]
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "detailVC") as? DetailViewController {
            detailVC.movie = movies[indexPath.row]
            self.delegate!.push(viewController: detailVC)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

extension RecomendationsTVC: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Recommended")
    }
}

protocol PushDelegate {
    func push(viewController: UIViewController)
}
