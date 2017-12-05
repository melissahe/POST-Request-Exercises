//
//  FavoriteImagesViewController.swift
//  POST-Request-Exercises
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class FavoriteImagesViewController: UIViewController {

    @IBOutlet weak var favoriteImagesTableView: UITableView!
    
    var favoriteImages: [FavoriteImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteImagesTableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        //to do
    }
    
}

extension FavoriteImagesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteImageCell", for: indexPath)
        
        //to do
        
        return cell
    }
}
