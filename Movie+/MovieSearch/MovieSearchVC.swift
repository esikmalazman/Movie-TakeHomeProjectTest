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
- Setup UI for Searchbar
- Connect delegate for Searchbar
- Setup & Perform network request to fetch query results
- Add validation to see if there any search query and results before, if has we show them on the screen list before start search, upon start search we clear the results from table view
- When user in offline mode, we direct to previously movie fetch (Bonus)

2. Display results in table view
- Setup UI for TableView
- Connect TV Datasource & Delegate
- Display search results from query
- Save the search results in Core Data
- Navigate selected results to Detail View

3. Integrate Core Data
- Setup Data Model to save results JSON
- Setup Class to handle CRUD operation
- Implement Method to save the search movie results
- Implement Method to save the favourites

4. Prepare Unit Test / UI Test
- Validate all UI connected include delegate, navigation controller, title
- Prepare to test Network & Core Data
""")

final class MovieSearchVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
}
