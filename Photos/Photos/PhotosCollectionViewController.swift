//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    var photos : [Photo]?
    let reuseIdentifier = "feedPhoto"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        // FILL ME IN
        
        
        
    }

    /* 
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc.
     */
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotosCollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
        if let photos = self.photos {
            loadImageForCell(photos[indexPath.row], imageView: cell.photoImage)
            cell.myPhoto = photos[indexPath.row]
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let photos = self.photos {
            return photos.count
        }
        return 0
    }
    
    /* Creates a session from a photo's url to download data to instantiate a UIImage. 
       It then sets this as the imageView's image. */
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        let photoURL = NSURL(string: photo.url)
//        if let photoData = NSData(contentsOfURL: photoURL) {
//            print(photoData)
//            if let photoImg = UIImage(data: photoData) {
//                imageView.image = photoImg
//            }
//        }
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(photoURL!) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                
                do {
                    if let photoImg = UIImage(data: data!) {
                        
                        imageView.image = photoImg
                        
                        
                    }
                    
//                    // DO NOT CHANGE BELOW
//                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
//                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
//                        dispatch_async(dispatch_get_main_queue()) {
//                            
//                        }
//                    }
                }
            }
        }
        task.resume()
        

    }
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView!.reloadData()
    }
    
//    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        <#code#>
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! PhotoViewController
        let sourcePhotoCell = sender as! PhotosCollectionViewCell
        destination.myPhoto = sourcePhotoCell.myPhoto

    }
    
}


