//
//  RecentsSearchVC.swift
//  Movie+
//
//  Created by Ikmal Azman on 27/06/2023.
//

import UIKit

final class RecentsSearchVC: UIViewController {
    
    @IBOutlet weak var recentsTableView : UITableView!
    
    var presenter : RecentsSearchPresenter = RecentsSearchPresenter()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.requestCacheSearchQueries()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recents Search"
        
        presenter.delegate = self
        configureRecentsTableView()
    }
}

// MARK:  UITableViewDataSource
extension RecentsSearchVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.movieQueryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movieQuery = presenter.recentQueries(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentCell.identifier, for: indexPath) as! RecentCell
        cell.configure(movieQuery)
        return cell
    }
}

// MARK:  UITableViewDelegate
extension RecentsSearchVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openRecentQueryResults(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Remove") { _, _, _ in
            self.presenter.removeRecentQueryResults(at: indexPath)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

// MARK:  RecentsSearchPresenterDelegate
extension RecentsSearchVC : RecentsSearchPresenterDelegate {
    func navigateToRecentDetailScreen(_ presenter: RecentsSearchPresenter, didTapQuery query: String, _ data: [Movie]) {
        let recentDetailVC = RecentDetailVC()
        recentDetailVC.setMovieList(data, query)
        navigationController?.pushViewController(recentDetailVC, animated: true)
    }
    
    func renderCacheQuerySearchResults(_ presenter: RecentsSearchPresenter, didLoadSuccess data: [MovieQuery]) {
        reloadMovieListTableView()
    }
    
    func renderCacheQuerySearchResults(_ presenter: RecentsSearchPresenter, didFailWithError error: Error) {
        showRequestCacheMovieErrorAlert(error)
    }
    
    func refreshCacheQuerySearchResults(_ presenter: RecentsSearchPresenter) {
        reloadMovieListTableView()
    }
}

private extension RecentsSearchVC {
    func configureRecentsTableView() {
        
        recentsTableView.register(RecentCell.nib(), forCellReuseIdentifier: RecentCell.identifier)
        recentsTableView.delegate = self
        recentsTableView.dataSource = self
        
        recentsTableView.separatorStyle = .none
    }
    
    func reloadMovieListTableView() {
        DispatchQueue.main.async {
            self.recentsTableView.reloadData()
        }
    }
    
    func showRequestCacheMovieErrorAlert(_ error : Error) {
        let alert = showErrorAlert(error.localizedDescription) {
            self.presenter.requestCacheSearchQueries()
        }
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
