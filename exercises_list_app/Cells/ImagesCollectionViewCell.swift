//
//  ImagesCollectionViewCell.swift
//  exercises_list_app
//
//  Created by Daniel Kilders Díaz on 20/01/2019.
//  Copyright © 2019 dankil. All rights reserved.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
}
