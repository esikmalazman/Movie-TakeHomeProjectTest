//
//  TestHelpers.swift
//  Movie+Tests
//
//  Created by Ikmal Azman on 26/06/2023.
//

import UIKit

/// Method to ask RunLoop to execute registered UIKit events immediately
func executeRunLoop() {
    RunLoop.current.run(until: Date())
}

// MARK:  SearchBar
func searchBarButtonCancelClicked(_ searchBar : UISearchBar) {
    searchBar.delegate?.searchBarCancelButtonClicked?(searchBar)
}

func searchBarSearchButtonClicked(_ searchBar : UISearchBar) {
    searchBar.delegate?.searchBarSearchButtonClicked?(searchBar)
}

// MARK:  UITableViewDataSource
func cellForRowAt(_ tableView : UITableView, at section : Int = 0, atRow row : Int) -> UITableViewCell? {
    let indexPath = IndexPath(row: row, section: section)
    let cell = tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath)
    return cell
}

func numberOfRows(_ tableView : UITableView, for section : Int = 0) -> Int? {
    let rowsCount = tableView.dataSource?.tableView(tableView, numberOfRowsInSection: section)
    return rowsCount
}

// MARK:  UITableViewDelegate
func didSelectRow(_ tableView : UITableView, at section : Int = 0, atRow row : Int) {
    let indexPath = IndexPath(row: row, section: section)
    tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
}

