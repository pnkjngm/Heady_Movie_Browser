//
//  Home.swift
//  Heady
//
//  Created by iSteer Inc. on 15/11/17.
//  Copyright © 2017 iSteer Inc. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftToast

class Home: UIViewController {

    @IBOutlet weak var gridView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var getMovies : String!
    var numberOfGrids : Int?
    var isSearchActive : Bool? = false
    var filtered : [String] = []
    var titles = [String]()
    var posters = [String]()
    
    var originalTitle = [String]()
    var releaseDate = [String]()
    var ratings = [String]()
    var overview = [String]()
    
    var viewModel : ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridView.register(UINib(nibName: "movieGrid", bundle: nil), forCellWithReuseIdentifier: "movieGrid")
        
        if getMovies == "MOST_POPULAR" {
            moviesDetailsFromServer(url: URLs.MOST_POPULAR.rawValue)
        } else if getMovies == "TOP_RATED" {
            moviesDetailsFromServer(url: URLs.TOP_RATED.rawValue)
        } else { // Default : Now Playing
            moviesDetailsFromServer(url: URLs.NOW_PLAYING.rawValue)
        }
        searchBar.delegate = self
    }
    
    //MARK:- Network Call / Calling Data from Server
    func moviesDetailsFromServer(url : String) {
        NetworkManager.getHTTPs(url: url, success: { (JSONResponse) in
            // Handle the data
            self.numberOfGrids = JSONResponse["results"].count
            for index in 0..<JSONResponse["results"].count {
                self.titles.append(JSONResponse["results"][index]["title"].string!)
                self.posters.append(JSONResponse["results"][index]["poster_path"].string!)
                self.originalTitle.append(JSONResponse["results"][index]["original_title"].string!)
                self.releaseDate.append(JSONResponse["results"][index]["release_date"].string!)
                self.ratings.append(String(describing : JSONResponse["results"][index]["vote_average"]))
                self.overview.append(JSONResponse["results"][index]["overview"].string!)
                
            }
            //Reload the table
            self.gridView.reloadData()
        }) { (failureResponse) in print("Failure", failureResponse) }
    }
    @IBAction func btnSettingTapped(_ sender: Any) {
        
        let sortBy = UIAlertController(title: nil, message: "Sort by", preferredStyle: .actionSheet)
        let home = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! Home
        let nav = UINavigationController(rootViewController: home)
        let mostPopular = UIAlertAction(title: "Most Popular", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            home.getMovies = "MOST_POPULAR"
            self.present(nav, animated: true, completion: nil)
        })
        let highestRated = UIAlertAction(title: "Top Rated", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            home.getMovies = "TOP_RATED"
            self.present(nav, animated: true, completion: nil)
        })
        let nowPlaying = UIAlertAction(title: "Now Playing", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            home.getMovies = "NOW_PLAYING"
            self.present(nav, animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        sortBy.addAction(mostPopular)
        sortBy.addAction(highestRated)
        sortBy.addAction(cancelAction)
        sortBy.addAction(nowPlaying)
        sortBy.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        self.present(sortBy, animated: true, completion: nil)
    }
}

extension Home : UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearchActive == true {
            return filtered.count
        } else {
            return numberOfGrids ?? 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        //viewModel Reference variable
        if isSearchActive == true {
            viewModel = ViewModel(title: self.filtered[indexPath.row], poster: self.posters[indexPath.row])
        } else {
            viewModel = ViewModel(title: self.titles[indexPath.row], poster: self.posters[indexPath.row])
        }
        let cell = gridView.dequeueReusableCell(withReuseIdentifier: "movieGrid", for: indexPath) as! movieGrid
        cell.viewModelData(viewModel: viewModel)
        return cell
    }
}

extension Home : UICollectionViewDelegate {
    
    public  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let details = storyboard?.instantiateViewController(withIdentifier: "Details") as! Details
            details.originalTitle = originalTitle[indexPath.row]
            details.posterString = posters[indexPath.row]
            details.releaseDate = releaseDate[indexPath.row]
            details.ratings = ratings[indexPath.row]
            details.overview = overview[indexPath.row]
            self.navigationController?.pushViewController(details, animated: true)
    }
}

extension Home : UISearchBarDelegate {
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearchActive = true
    }
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearchActive = false
    }
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = false
    }
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = false
        searchBar.endEditing(true)
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = self.titles.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        
        if filtered.count > 0 {
            isSearchActive = true
        } else if searchText.count == 0 {
            isSearchActive = false
        }
        self.gridView.reloadData()
    
    }
}
