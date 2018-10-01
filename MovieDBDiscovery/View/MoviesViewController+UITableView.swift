//
//  MoviesViewController+UITableView.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 24.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import UIKit

extension MoviesViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.moviesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        guard let movie = viewModel.movie(at: indexPath.row) else {
            preconditionFailure("The item is not found at the requested index")
        }
        let movieVM = MovieViewModel(movie: movie)
        cell.configure(with: movieVM)
        return cell
    }
}

extension MoviesViewController: UITableViewDataSourcePrefetching {
    func tableView(_: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let index = indexPaths.last?.row,
            index >= viewModel.moviesCount - 5 else {
            return
        }
        viewModel.loadNextPage()
    }
}
