//
//  InTheBagDetailsVC.swift
//  PuttMetricsAPP
//
//  Created by User on 1/3/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit

class InTheBagDetailsVC: UIViewController {

//
//    var selectionImage: UIImage!
//    var discName: String!
//    var discDescription: String!
    
    var disc : Discs?
    
    @IBOutlet weak var Imagedetails: UIImageView!
    @IBOutlet weak var discNameLabel: UILabel!
    @IBOutlet weak var discDescriptionLabel: UILabel!
    
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    view.setGradientBackground(colorOne: UIColor.green, colorTwo: UIColor.blue)
    imageViewHeightConstraint.constant = view.frame.width
    
        if let disc = disc {
            navigationItem.title = disc.name
            Imagedetails.image = disc.image
            discNameLabel.text = disc.name
            discDescriptionLabel.text = disc.description
            
            
            
            print("Type: \(disc.name)")
        }
    }



}
