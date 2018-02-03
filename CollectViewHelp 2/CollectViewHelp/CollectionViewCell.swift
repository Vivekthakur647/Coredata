//
//  CollectionViewCell.swift
//  PuttMetricsAPP
//
//  Created by User on 1/3/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionImage: UIImageView!
    @IBOutlet weak var cellImage: UIImageView!
 
   
    
    var disc: Discs? {
        didSet {
            if let disc = disc {
                cellImage.image = disc.image
                titleLabel.text = disc.name
            }
        }
    }
    
    
    
    
    var isEditing: Bool = false {
        didSet {
            selectionImage.isHidden = !isEditing
        }
    }
    
    override var isSelected: Bool{
        didSet {
            if isEditing {
                selectionImage.image = isSelected ? UIImage(named: "Checked") : UIImage(named: "Unchecked")
            }
        }
    }

    
    override func prepareForReuse() {
        cellImage.image = nil
    }
    
}

