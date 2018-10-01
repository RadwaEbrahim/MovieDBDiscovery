//
import AlamofireImage
//  MovieCell.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 16.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet var genre: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var score: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var poster: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()

        poster.af_cancelImageRequest()
        poster.image = nil
    }

    func configure(with movie: MovieViewModel) {
        title.text = movie.title
        score.text = movie.popularity
        if movie.posterURL != nil {
            poster.af_setImage(withURL: movie.posterURL!)
        }
        date.text = movie.releaseDate
        genre.text = movie.genre
    }
}
