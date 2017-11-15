//
//  ViewModel.swift
//  Heady
//
//  Created by iSteer Inc. on 15/11/17.
//  Copyright © 2017 iSteer Inc. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    private var movie : Movies

    init(title : String, poster : String) {
        self.movie = Movies(title : title, poster : poster)
    }
    
    var title : String {
        return movie.title
    }
    var poster : String {
        return movie.poster
    }
}
