//
//  MoviesViewController.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 16.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var searchFooter: SearchFooter!

    var viewModel: MoviesListViewModelProtocol!
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingIndicator.startAnimating()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.configureSearchController()
        self.tableViewSetup()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search By movie name"
        navigationItem.searchController = searchController
        definesPresentationContext = true

        // Setup the Scope Bar
        searchController.searchBar.delegate = self

        // Setup the search footer
        tableView.tableFooterView = searchFooter
    }

    func tableViewSetup() {
        self.tableView.rowHeight = UITableView.automaticDimension
    }

}

extension MoviesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            searchFooter.setIsFilteringToShow(filteredItemCount: 0, of: 1)
            return viewModel.moviesCount
        }

        searchFooter.setNotFiltering()
        return viewModel.moviesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        guard let movie = viewModel.movieAtIndex(index: indexPath.row) else {
            preconditionFailure("The item is not found at the requested index")
        }
        let movieVM = MovieViewModel(movie: movie)
        cell.configure(with: movieVM)
        return cell
    }
}

extension MoviesViewController: MoviesViewModelDelegate {
    func moviesLoaded() {
        tableView.reloadData()
        self.loadingIndicator.stopAnimating()
    }

    func loadingMoviesFailed(error: Error) {
        let alert = UIAlertController.init(title: "We are sorry!",
                               message: error.localizedDescription,
                               preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: false)
        self.loadingIndicator.stopAnimating()
    }
}
