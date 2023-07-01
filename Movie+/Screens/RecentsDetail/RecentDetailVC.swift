//
//  RecentDetailVC.swift
//  Movie+
//
//  Created by Ikmal Azman on 29/06/2023.
//

import UIKit

final class RecentDetailVC: UIViewController {
    
    @IBOutlet weak var moviesListTableView : UITableView!
    
    var movieList : [Movie] = []
    var recentsQueryTitle : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMovieListTableView()
    }
    
    func setMovieList(_ data : [Movie], _ title : String) {
        recentsQueryTitle = title
        movieList = data
    }
}

extension RecentDetailVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movieList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieResultCell.identifier, for: indexPath) as! MovieResultCell
        cell.configure(movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search result for : \(recentsQueryTitle)"
    }
}

private extension RecentDetailVC {
    func configureMovieListTableView() {
        moviesListTableView.register(MovieResultCell.nib(), forCellReuseIdentifier: MovieResultCell.identifier)
        
        if #available(iOS 15.0, *) {
            moviesListTableView.sectionHeaderTopPadding = 0
        }
        moviesListTableView.dataSource = self
        moviesListTableView.reloadData()
    }
}
