//
//  FavouritesVC.swift
//  Movie+
//
//  Created by Ikmal Azman on 27/06/2023.
//

import UIKit

final class FavouritesVC: UIViewController {
    
    @IBOutlet weak var favouriteTableView : UITableView!
    
    var favouriteList : [MovieFavourites] = []
    lazy var coreDataStack : CoreDataStack = PersistentDelegate.shared.coredataStack
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favourites"
        
        coreDataStack.fetchContext(of: MovieFavourites.self, with: [], and: nil) { result in
            if let data = try? result.get() {
                self.favouriteList = data
                
                DispatchQueue.main.async {
                    self.favouriteTableView.reloadData()
                }
            }
        }
        
        favouriteTableView.register(MovieResultCell.nib(), forCellReuseIdentifier: MovieResultCell.identifier)
        favouriteTableView.delegate = self
        favouriteTableView.dataSource = self
    }
    
}

extension FavouritesVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favourite = favouriteList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieResultCell.identifier, for: indexPath) as! MovieResultCell
        let movie = Movie(id: Int(favourite.id), title: favourite.title, releaseDate: favourite.releaseDate, posterPath: favourite.posterPath)
        cell.configure(movie)
        return cell
    }
}

extension FavouritesVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
