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
    var viewModel: MoviesListViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingIndicator.startAnimating()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.tableViewSetup()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableViewSetup() {
        self.tableView.rowHeight = UITableView.automaticDimension
    }

}

extension MoviesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    }
}
