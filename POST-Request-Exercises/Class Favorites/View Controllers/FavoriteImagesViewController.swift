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
        FavoriteImageAPIClient.manager.getImages(
            completionHandler: { (onlineImages) in
                self.favoriteImages = onlineImages
                self.favoriteImagesTableView.reloadData()
        },
            errorHandler: {print($0)})
    }
    
}

//Table View Methods
extension FavoriteImagesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteImageCell", for: indexPath)
        let currentImage = favoriteImages[indexPath.row]
        
        if let imageCell = cell as? FavoriteImageTableViewCell {
            imageCell.favoriteImageView.image = nil
            
            ConvertToImage.tool.getImage(
                from: currentImage.imageURLString,
                completionHandler: { (onlineImage) in
                    imageCell.favoriteImageView.image = onlineImage
                    imageCell.setNeedsLayout()
            },
                errorHandler: {print($0)})
            
            return imageCell
        }
        
        return cell
    }
}
