//
//  PhotoCell.swift
//  JsonPlaceholder
//
//  Created by apple on 18.01.2020.
//  Copyright © 2020 Mustafa KILINÇ. All rights reserved.
//

import UIKit



class PhotoCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var lblPhotoTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgPhoto.layer.cornerRadius = 10
        
       
        
    }
}
