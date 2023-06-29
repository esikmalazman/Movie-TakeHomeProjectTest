//
//  RecentsSearchVC.swift
//  Movie+
//
//  Created by Ikmal Azman on 27/06/2023.
//

import UIKit

final class RecentsSearchVC: UIViewController {
    
    @IBOutlet weak var recentsTableView : UITableView!
    
    let testCell = "testCell"
    
    var movieQueries = [MovieQuery]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
#warning("move to presenter")
        AppDelegate.shared.cdStack.fetchContext(of: MovieQuery.self, with: []) { result in
            self.movieQueries = result
            DispatchQueue.main.async {
                self.recentsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRecentsTableView()
    }
}

extension RecentsSearchVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieQueries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: testCell, for: indexPath)
        cell.textLabel?.text = movieQueries[indexPath.row].query
        return cell
    }
}

extension RecentsSearchVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

private extension RecentsSearchVC {
    func configureRecentsTableView() {
        title = "Recents Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        recentsTableView.register(UITableViewCell.self, forCellReuseIdentifier: testCell)
        recentsTableView.delegate = self
        recentsTableView.dataSource = self
    }
}
