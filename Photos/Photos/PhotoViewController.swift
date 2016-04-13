//
//  PhotoViewController.swift
//  Photos
//
//  Created by Susanna Souv on 4/12/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var unliked : String = "♡"
    var liked : String = "♥︎"
    var likeStatus : Bool = false
    var numberOfLikes : Int = 0
    var username : String!
    var myPhoto : Photo!
    var datePosted : String!
    
    @IBOutlet weak var currPhoto: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var datePostedLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let myCurrPhoto = self.myPhoto {
            likeButton.addTarget(self, action: #selector(PhotoViewController.likeButtonTapped), forControlEvents: .TouchUpInside)
            numberOfLikes = myCurrPhoto.likes
            username = myCurrPhoto.username
            loadPhoto()
            updateLikes()
            if let userPhotoName = username {
                usernameLabel.text = userPhotoName
            }
            displayDate(myCurrPhoto.postTime)
            setButtonImage()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func likeButtonTapped() {
        if likeStatus {
            // true means already liked
            numberOfLikes -= 1
            
        }
        else {
            numberOfLikes += 1
        }
        likeStatus = !likeStatus
        updateLikes()
        setButtonImage()
    }
    
    func updateLikes () {
        numberOfLikesLabel.text = String(numberOfLikes)
    }
    
    func setButtonImage() {
        if likeStatus {
            likeButton.setTitle(liked, forState: .Normal)
        }
        else {
            likeButton.setTitle(unliked, forState: .Normal)
        }
    }
    
    func loadPhoto() {
        let photoURL = NSURL(string: myPhoto.hQurl)
        let task = NSURLSession.sharedSession().dataTaskWithURL(photoURL!) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                do {
                    if let photoImg = UIImage(data: data!) {
                        self.currPhoto.image = photoImg
                        
                    }
                }
            }
        }
        task.resume()
        
    }
    func displayDate(postTimeString: String) {
        let datePostedDouble : Double = Double(postTimeString)!
        let datePostedNSDate : NSDate = NSDate(timeIntervalSince1970: datePostedDouble)
        
        // making it pretty
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") // MURRICA
        self.datePosted = dateFormatter.stringFromDate(datePostedNSDate)

        
        datePostedLabel.text = self.datePosted
    }
}
