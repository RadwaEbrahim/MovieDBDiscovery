//
//  MoviesViewController+SearchController.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 24.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import UIKit

extension MoviesViewController: UISearchBarDelegate {

    func filterContentForSearchText(_ searchText: String) {
        viewModel.searchText = searchText
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.loadMoviesList()
    }

    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func isFiltering() -> Bool {
        return searchController.isActive && (!searchBarIsEmpty())
    }
}

extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

