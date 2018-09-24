//
//  MovieCell.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 16.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class MovieCell: UITableViewCell {

    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var poster: UIImageView!


    override func prepareForReuse() {
        super.prepareForReuse()

        poster.af_cancelImageRequest()
        poster.image = nil
    }

    func configure(with movie: MovieViewModel) {
        self.title.text = movie.title
        self.score.text = movie.popularity
        if movie.posterURL != nil {
            self.poster.af_setImage(withURL: movie.posterURL!)
        }
        self.date.text = movie.releaseDate
        self.genre.text = movie.genre
    }
}
