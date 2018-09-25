//
//  MoviesViewController+UITableView.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 24.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import UIKit


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
