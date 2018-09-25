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

    let searchController = UISearchController(searchResultsController: nil)
    let refreshControl = UIRefreshControl()
    var viewModel: MoviesListViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadMoviesList()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configureSearchController()
        self.tableViewSetup()
        self.loadingIndicator.startAnimating()
    }

    @objc func handleRefresh(_ sender: Any) {
        viewModel.refresh()
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
        self.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: .valueChanged)
    }
}

extension MoviesViewController: MoviesViewModelDelegate {
    func moviesLoaded() {
        tableView.reloadData()
        refreshControl.endRefreshing()
        self.loadingIndicator.stopAnimating()
    }

    func loadingMoviesFailed(error: Error) {
        let alert = UIAlertController.init(title: "We are sorry!",
                                           message: error.localizedDescription,
                                           preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: false)
        self.loadingIndicator.stopAnimating()
    }

    func isLoading(loading: Bool){
        if loading {
            self.loadingIndicator?.startAnimating()
        } else {
            self.loadingIndicator?.stopAnimating()
        }
    }
}
