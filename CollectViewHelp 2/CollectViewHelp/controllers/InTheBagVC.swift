//
//  InTheBagVC.swift
//  PuttMetricsAPP
//
//  Created by User on 1/3/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit
import CoreData












class InTheBagVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
    
    
    @IBOutlet private weak var deleteButton: UIBarButtonItem!
    @IBOutlet private weak var addButton: UIBarButtonItem!
    @IBOutlet private weak var collectionView:UICollectionView!

    private let dataSource = CollectionViewDataSource()
    private let pictureInfoSource = PictureInfoVC()
    
    var imageToSend = UIImage()
    var images:[UIImage]!
    var imagePathArray = [String]()

 
    
    
    
    
   
    
    
 
    
    
    
    


    @IBAction func deleteSelected(_ sender: Any) {
        if let selected = collectionView.indexPathsForSelectedItems {
            
            //Here for debugging reasons.
            print("Fired")
            print(collectionView.indexPathsForSelectedItems)

            
            dataSource.deleteItemsAtIndexPaths(selected)

            collectionView.reloadData()
        
        }


    }




    
    
    
   @IBAction func addItem() {
        
     //   let index = IndexPath(row: _images.count - 1, section: 0)
    
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
   
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera is not available")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        
        self.present(actionSheet,animated: true,completion: nil)

    


    }
    
  
    
    
    
    
    
    
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
       
        imageToSend = image
   
       picker.dismiss(animated: true, completion: nil)
        
        
        performSegue(withIdentifier: "sendToImageInfo", sender: self)
    
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    

    
    @objc func refresh() {
     //   collectionView.reloadData()
       collectionView.refreshControl?.endRefreshing()
        print("resfresh func was called")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up a 3-column Collection View
        let width = view.frame.size.width  / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width:width, height:width)
        layout.sectionHeadersPinToVisibleBounds = true
        // Refresh Control
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        collectionView.refreshControl = refresh

       navigationItem.rightBarButtonItem = editButtonItem
       self.navigationController?.navigationBar.prefersLargeTitles = true
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //dataSource.loadImages()
        collectionView.reloadData()
        print("Did reappear")
    }
    
    
    
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInTheBagDetails" {
            if let dest = segue.destination as? InTheBagDetailsVC {
            
          dest.disc = sender as? Discs
            
            }
        }
        
        
        if segue.identifier == "sendToImageInfo" {
            if let destination = segue.destination as? PictureInfoVC {
                destination._imageTemp = imageToSend
                
                
            }
            
        }
    }

    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        deleteButton.isEnabled = editing
        
        addButton.isEnabled = !editing
        
        collectionView.allowsMultipleSelection = editing
        
        
        guard let indexes = collectionView?.indexPathsForVisibleItems else {
            return
        }

        for index in indexes {
            let cell = collectionView?.cellForItem(at: index) as! CollectionViewCell
            cell.isEditing = editing
        }
    }
    

 
}
   
    
    
    
    
    
    
    
    

    
    
    




extension InTheBagVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
        view.title = dataSource.titleForSectionAtIndexPath(indexPath)
        return view
    }
    
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        dataSource.loadImages()
        
    
    
       return dataSource.numberOfSections
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSource.numberOfDiscsInSection(section)
   
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
    
        cell.disc = dataSource.discForItemAtIndexPath(indexPath)

        cell.isEditing = isEditing
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            let disc = dataSource.discForItemAtIndexPath(indexPath)
            performSegue(withIdentifier: "toInTheBagDetails", sender: disc)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditing {
            if let selected = collectionView.indexPathsForSelectedItems, selected.count == 0 {
               
            }
        }
    }
    
    
}



extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

