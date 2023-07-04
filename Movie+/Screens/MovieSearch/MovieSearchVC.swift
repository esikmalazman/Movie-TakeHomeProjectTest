//
//  MovieSearchVC.swift
//  Movie+
//
//  Created by Ikmal Azman on 22/06/2023.
//

import UIKit

final class MovieSearchVC: UIViewController {
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    lazy var emptyState : EmptyState = {
        let vc = EmptyState()
        return vc
    }()
    
    var presenter : MovieSearchPresenter = MovieSearchPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        
        configureEmptyState()
        configureSearcBar()
        configureTableView()
        
        presenter.delegate = self
    }
}

// MARK:  UISearchBarDelegate
extension MovieSearchVC : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let queryText = searchBar.text, !queryText.isEmpty else {return}
        
        presenter.clearMovieList()
        presenter.requestMovie(for: queryText)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearchBar()
    }
}

// MARK:  UITableViewDataSource
extension MovieSearchVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = presenter.movie(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieResultCell.identifier, for: indexPath) as! MovieResultCell
        cell.configure(movie)
        return cell
    }
}

// MARK:  UITableViewDelegate
extension MovieSearchVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectMovie(at: indexPath.row)
    }
}

extension MovieSearchVC : MovieSearchPresenterDelegate {
    func saveMovieSearchResults(_ presenter: MovieSearchPresenter, didFailWithError error: Error) {
        showSaveMovieErrorAlert(error)
    }
    
    func renderMovieSearchResults(_ presenter: MovieSearchPresenter, didLoadSuccess data: [Movie]) {
        reloadTableView()
        shouldHideEmptyState(true)
    }
    
    func renderMovieSearchResults(_ presenter: MovieSearchPresenter, didFailWithError error: Error) {
        showRequestMovieErrorAlert(error)
    }
    
    func navigateToMovieDetailScreen(_ presenter: MovieSearchPresenter, didTapMovie movie : Movie) {
        let movieDetailVC = MovieDetailVC()
        movieDetailVC.requestMovieDetail(for: movie)
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}

private extension MovieSearchVC {
    func configureTableView() {
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        
        searchResultsTableView.register(RecentlySearchCell.nib(), forCellReuseIdentifier: RecentlySearchCell.identifier)
        searchResultsTableView.register(MovieResultCell.nib(), forCellReuseIdentifier: MovieResultCell.identifier)
    }
    
    func configureSearcBar() {
        searchBar.placeholder = "Search for Movies"
        searchBar.showsCancelButton = true
        searchBar.delegate = self
    }
    
    func configureEmptyState() {
        emptyState.layout(in: view)
        emptyState.setup(for: .search)
    }
    
    func clearSearchBar() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.searchResultsTableView.reloadData()
        }
    }
    
    func showRequestMovieErrorAlert(_ error : Error) {
        let alert = showErrorAlert(error.localizedDescription) {
            self.presenter.requestMovie(for: self.searchBar.text ?? "")
        }
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func showSaveMovieErrorAlert(_ error : Error) {
        let alert = showBasicAlert("Oops! Something went wrong!", error.localizedDescription)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func shouldHideEmptyState(_ state : Bool) {
        DispatchQueue.main.async {
            self.emptyState.view.isHidden = state
        }
    }
}
