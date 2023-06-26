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


