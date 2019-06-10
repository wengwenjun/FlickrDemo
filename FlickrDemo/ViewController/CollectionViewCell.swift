//
//  CollectionViewCell.swift
//  FlickrDemo
//
//  Created by Wenjun Weng on 6/9/19.
//  Copyright © 2019 Wenjun Weng. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    func configureImageView(photo: ImageObject) {
       imageView.sd_setImage(with: photo.getImageData(), completed: nil)
    }
}
