//
//  Photo.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import Foundation

class Photo {
    /* The number of likes the photo has. */
    var likes : Int!
    /* The string of the url to the photo file. */
    var url : String!
    /* The username of the photographer. */
    var username : String!
    var hQurl : String!
    var postTime : String!
    
    var imageDictionary : NSDictionary!
    /* Parses a NSDictionary and creates a photo object. */

    init (data: NSDictionary) {
        // FILL ME IN
        // HINT: use nested .valueForKey() calls, and then cast using 'as! TYPE'
//        print(data)

        likes = data.valueForKey("likes")?.valueForKey("count") as! Int
        username = data.valueForKey("user")?.valueForKey("username") as! String
        imageDictionary = data.valueForKey("images") as! NSDictionary
        url = imageDictionary.valueForKey("low_resolution")?.valueForKey("url") as! String
        hQurl = imageDictionary.valueForKey("standard_resolution")?.valueForKey("url") as! String
        postTime = data.valueForKey("created_time") as! String
    }

}