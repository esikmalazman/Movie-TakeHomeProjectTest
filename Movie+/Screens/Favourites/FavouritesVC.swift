//
//  FavouritesVC.swift
//  Movie+
//
//  Created by Ikmal Azman on 27/06/2023.
//

import UIKit

final class FavouritesVC: UIViewController {
    
    @IBOutlet weak var favouriteTableView : UITableView!
    
    var presenter : FavouritesPresenter = FavouritesPresenter()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.requestFavouritesMovie()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favourites"
        
        presenter.delegate = self
        configureFavouritesTableView()
    }
}

// MARK:  UITableViewDataSource
extension FavouritesVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.favouriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favouriteMovie = presenter.favouriteList(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieResultCell.identifier, for: indexPath) as! MovieResultCell
        cell.configure(favouriteMovie)
        return cell
    }
}

// MARK:  UITableViewDelegate
extension FavouritesVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openFavouriteMovieList(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Remove") { _, _, _ in
            self.presenter.removeFavouriteMovieList(at: indexPath)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

// MARK:  FavouritesPresenterDelegate
extension FavouritesVC : FavouritesPresenterDelegate {
    
    func navigateToFavouriteMovieDetailScreen(_ presenter: FavouritesPresenter, _ data: MovieDetail) {
        let movieDetailVC = MovieDetailVC()
        movieDetailVC.loadViewIfNeeded()
        movieDetailVC.configure(data, shouldHideBookmark: true)
        
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    func renderFavouritesMovie(_ presenter: FavouritesPresenter, didLoadSuccess data: [MovieFavourites]) {
        self.reloadTableView()
    }
    
    func renderFavouritesMovie(_ presenter: FavouritesPresenter, didFailWithError error: Error) {
        showRenderMovieFavouritesErrorAlert(error)
    }
    
    func refreshFavouriteMovie(_ presenter: FavouritesPresenter) {
        self.reloadTableView()
    }
}

private extension FavouritesVC {
    func configureFavouritesTableView() {
        favouriteTableView.register(MovieResultCell.nib(), forCellReuseIdentifier: MovieResultCell.identifier)
        favouriteTableView.delegate = self
        favouriteTableView.dataSource = self
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.favouriteTableView.reloadData()
        }
    }
    
    func showRenderMovieFavouritesErrorAlert(_ error : Error) {
        let alert = showErrorAlert(error.localizedDescription) {
            self.presenter.requestFavouritesMovie()
        }
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
