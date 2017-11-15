//
//  URLs.swift
//  Heady
//
//  Created by iSteer Inc. on 14/11/17.
//  Copyright © 2017 iSteer Inc. All rights reserved.
//

import Foundation

public enum URLs : String {
 
    case NOW_PLAYING       = "https://api.themoviedb.org/3/movie/now_playing?api_key=2de2547e45eddeb6b4db3296840b6720&language=en-US&page=1"
    case MOST_POPULAR      = "https://api.themoviedb.org/3/movie/popular?api_key=2de2547e45eddeb6b4db3296840b6720&language=en-US&page=1"
    case TOP_RATED         = "https://api.themoviedb.org/3/movie/top_rated?api_key=2de2547e45eddeb6b4db3296840b6720&language=en-US&page=1"
    case BASE_PATH_POSTER  = "https://image.tmdb.org/t/p/w150/"
}
