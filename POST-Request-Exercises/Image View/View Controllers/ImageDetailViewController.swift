//
//  ImageDetailViewController.swift
//  POST-Request-Exercises
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {

    @IBOutlet weak var fullSizeImageView: UIImageView!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var downloadsLabel: UILabel!
    
    var image: Image!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func addImageButtonPressed(_ sender: UIButton) {
        //to do - set up post requests
    }
    
    func setUpUI() {
        //Labels
        viewsLabel.text = "\(image.numberOfViews) views"
        likesLabel.text = "\(image.numberOfLikes) likes"
        favoritesLabel.text = image.numberOfFavorites.description
        usernameLabel.text = image.userName
        downloadsLabel.text = image.numberOfDownloads.description
        
        setUpImages()
    }

    func setUpImages() {
        //full size image
        let fullSizeImageStr = image.fullSizeURLString ?? image.thumbnailURLString
        
        ConvertToImage.tool.getImage(
            from: fullSizeImageStr,
            completionHandler: { (onlineImage) in
                self.fullSizeImageView.image = onlineImage
        },
            errorHandler: { _ in
                self.fullSizeImageView.image = #imageLiteral(resourceName: "image_not_available")
        })
        
        //user image
        ConvertToImage.tool.getImage(
            from: image.userImageURLString,
            completionHandler: { (onlineImage) in
                self.userImageView.image = onlineImage
        },
            errorHandler: { _ in
                self.fullSizeImageView.image = #imageLiteral(resourceName: "image_not_available")
        })
    }
}
