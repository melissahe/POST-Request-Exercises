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
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageTableView.delegate = self
        imageTableView.dataSource = self
        imageSearchBar.delegate = self
    }
    
    func loadData() {
        ImageAPIClient.manager.getImages(
            from: searchTerm,
            completionHandler: { (onlineImages) in
                self.images = onlineImages
                self.imageTableView.reloadData()
        },
            errorHandler: { (appError) in
                let alertController = UIAlertController(title: "ERROR:", message: "\(appError)", preferredStyle: UIAlertControllerStyle.alert)
                let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let selectedCell = sender as? ImageTableViewCell,
            let selectedIndex = imageTableView.indexPath(for: selectedCell),
            let destinationVC = segue.destination as? ImageDetailViewController {
            let currentImage = images[selectedIndex.row]
            
            destinationVC.image = currentImage
        }
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
        
        if let imageCell = cell as? ImageTableViewCell {
            
            imageCell.searchImageView.image = nil
            
            ConvertToImage.tool.getImage(
                from: currentImage.thumbnailURLString,
                completionHandler: { (onlineImage) in
                    imageCell.searchImageView.image = onlineImage
                    imageCell.setNeedsLayout()
            },
                errorHandler: {print($0)})
            
            return imageCell
        }
        
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
    
    //make sure search text doesn't go over 100 character limit
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if searchBar.text?.count == 100 && text != "" {
            //error message
            let alertController = UIAlertController(title: "ERROR:", message: "You cannot have more than 100 characters in the search query.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
}
