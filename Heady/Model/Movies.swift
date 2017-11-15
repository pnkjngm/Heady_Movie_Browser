//
//  Movies.swift
//  Heady
//
//  Created by iSteer Inc. on 15/11/17.
//  Copyright © 2017 iSteer Inc. All rights reserved.
//

import UIKit

class Movies: NSObject {
    
    var title : String!
    var poster : String!

    init(title : String, poster : String) {
        self.title = title
        self.poster = poster
    }
}
