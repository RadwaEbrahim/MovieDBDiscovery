//
//  MoviesViewController.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 16.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import UIKit

class MoviesViewController: UITableViewController {
    var viewModel: MoviesListViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewSetup()


    }
    override func viewDidAppear(_ animated: Bool) {
        //tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableViewSetup() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 350
    }


}

extension MoviesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    }

    func loadingMoviesFailed(error: Error) {
        //show error
    }


}
