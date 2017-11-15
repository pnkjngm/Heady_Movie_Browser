//
//  Details.swift
//  Heady
//
//  Created by iSteer Inc. on 15/11/17.
//  Copyright © 2017 iSteer Inc. All rights reserved.
//

import UIKit

class Details: UIViewController {

    @IBOutlet weak var lblOriginalTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblRatings: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    
    var originalTitle : String!
    var posterString : String!
    var overview : String!
    var ratings : String!
    var releaseDate : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let str = URLs.BASE_PATH_POSTER.rawValue.appending(posterString)
            let url = URL(string : str)
            let imageData = try Data(contentsOf : url!)
            imgView.image = UIImage(data: imageData)
        } catch {
            print("Exception Occurred")
        }
        
        lblOriginalTitle.text = originalTitle
        lblReleaseDate.text = "Release Date : ".appending(releaseDate)
        lblRatings.text = "Ratings : ".appending(ratings)
        lblOverview.text = overview
    }

}
