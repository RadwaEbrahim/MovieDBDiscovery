//
//  MoviesViewController.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 16.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import UIKit

class MoviesViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewSetup()


    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableViewSetup() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 350
    }


}

extension MoviesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.title.text = "yalla"
        cell.score.text = "10"
        cell.date.text = "1222"
        cell.genre.text = "ccc ffff ggggggggg aaqwertgtee"
        return cell
    }
}

