//
//  movieGrid.swift
//  Heady
//
//  Created by iSteer Inc. on 14/11/17.
//  Copyright © 2017 iSteer Inc. All rights reserved.
//

import UIKit

class movieGrid: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //
    }
    
    func viewModelData(viewModel : ViewModel) {
        self.lblTitle.text = viewModel.title
        do {
                let imageData = try  Data(contentsOf : URL(string : URLs.BASE_PATH_POSTER.rawValue.appending(viewModel.poster))!)
                self.imgView.image = UIImage(data : imageData)
            } catch {
                    print("Some Exception Occured !!")
                
        }
        
    }
    
}
