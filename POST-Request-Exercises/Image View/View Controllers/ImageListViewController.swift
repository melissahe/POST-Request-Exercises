//
//  ViewController.swift
//  POST-Request-Exercises
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ImageListViewController: UIViewController {
    @IBOutlet weak var imageSearchBar: UISearchBar!
    @IBOutlet weak var imageTableView: UITableView!
    
    var images: [Image] = []
    
    var searchTerm: String = "" {
        didSet {
            //to do
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageTableView.delegate = self
        imageTableView.dataSource = self
    }
    
    func loadData() {
        //to do - get images for table view
        //should reload tableview
    }

}

//Table View Methods
extension ImageListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //to do
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
        let currentImage = images[indexPath.row]
        
        //to do
        
        return cell
    }
    
}

//Search Bar Methods
extension ImageListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        
        searchTerm = searchText
    }
}
