//
//  MovieSearchVC.swift
//  Movie+
//
//  Created by Ikmal Azman on 22/06/2023.
//

import UIKit

#warning("""
Todo's
1. Searchbar to search movies by title
- Setup UI for Searchbar ✅
- Connect delegate for Searchbar ✅
- Setup & Perform network request to fetch query results ✅
- Add validation to see if there any search query and results before, if has we show them on the screen list before start search, upon start search we clear the results from table view
- When user in offline mode, we direct to previously movie fetch (Bonus)

2. Display results in table view
- Setup UI for TableView ✅
- Connect TV Datasource & Delegate ✅
- Display search results from query ✅
- Setup UI for custom cell ✅
- Save the search results in Core Data
- Navigate selected results to Detail View

3. Integrate Core Data
- Setup Data Model to save results JSON
- Setup Class to handle CRUD operation
- Implement Method to save the search movie results
- Implement Method to save the favourites

4. Prepare Unit Test / UI Test
- Validate all UI connected include delegate, navigation controller, title ✅
- Prepare to test Network & Core Data
""")

final class MovieSearchVC: UIViewController {
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter : MovieSearchPresenter = MovieSearchPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        
        configureSearcBar()
        configureTableView()
        
        presenter.delegate = self
    }
}

// MARK:  UISearchBarDelegate
extension MovieSearchVC : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let queryText = searchBar.text ?? ""
        
        presenter.insertRecentlySearchQueries(queryText)
        presenter.clearMovieList()
        presenter.requestMovie(for: queryText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearchBar()
    }
}

// MARK:  UITableViewDataSource
extension MovieSearchVC : UITableViewDataSource {
#warning("as for now we display 1 section for results of query, then later we check if there any cache search results if have we show 2 section")
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
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
        
    }
}

extension MovieSearchVC : MovieSearchPresenterDelegate {
    func renderMovieSearchResults(_ presenter: MovieSearchPresenter, didLoadSuccess data: [Movie]) {
        reloadTableView()
    }
    
    func renderMovieSearchResults(_ presenter: MovieSearchPresenter, didFailWithError error: Error) {
        reloadTableView()
    }
}

private extension MovieSearchVC {
    func configureTableView() {
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        
        searchResultsTableView.register(MovieResultCell.nib(), forCellReuseIdentifier: MovieResultCell.identifier)
    }
    
    func configureSearcBar() {
        searchBar.placeholder = "Search for Movies"
        searchBar.showsCancelButton = true
        searchBar.delegate = self
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
}
