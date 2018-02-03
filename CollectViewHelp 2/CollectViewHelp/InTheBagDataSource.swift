


//  PuttMetricsAPP
//
//  Created by User on 1/22/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//


import UIKit
import CoreData


class CollectionViewDataSource {
    
   // var immutableDiscs = [Discs]()
    var discs = [Discs]()
    var sections = [String]()
   
   // var _collectionView : InTheBagVC?
    
    
    var count: Int {
        return discs.count
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    

    
    
    
        init() {
        
           discs = loadImages()
        }
    
    
   
    
    func deleteItemsAtIndexPaths(_ indexPaths: [IndexPath]) {
        
        let fetchRequest: NSFetchRequest<CollectViewImages> = CollectViewImages.fetchRequest()
        var receivedImages = try! PersistenceService.context.fetch(fetchRequest)
        let context: NSManagedObjectContext = PersistenceService.context
        
        
        
        print("start of  delete item at indexpath")
        var indexes = [Int]()
        for indexPath in indexPaths {
            context.delete(receivedImages[absoluteIndexForIndexPath(indexPath)] as NSManagedObject)
            PersistenceService.saveContext()

            indexes.append(absoluteIndexForIndexPath(indexPath))
        }
        
        
        var newDiscs = [Discs]()
        for (index, disc) in discs.enumerated() {
            if !indexes.contains(index) {
                
                //Potential FIX
                // context.delete(receivedImages[index] as NSManagedObject)
                newDiscs.append(disc)
            }
        }
        
      //  PersistenceService.saveContext()
        discs = newDiscs
        print("finished delete item and indexpath")
//         discs = loadImages()
    }
    
    
    
    func discForItemAtIndexPath(_ indexPath: IndexPath) -> Discs? {
        if indexPath.section > 0 {
            let discsInThatSection = discsForSection(indexPath.section)
            return discsInThatSection[indexPath.item]
        } else {
            return discs[indexPath.item]
        }
    }
    
    
    
    func titleForSectionAtIndexPath(_ indexPath: IndexPath) -> String? {
        if indexPath.section < sections.count {
            return sections[indexPath.section]
        }
        return nil
    }
    
    
    
    func loadImages () -> [Discs] {
        
        var collectionImagesReceived = [CollectViewImages]()
        
        if let fetchRequest: NSFetchRequest<CollectViewImages> = CollectViewImages.fetchRequest() {
            do {
                let receivedImages = try PersistenceService.context.fetch(fetchRequest)
                collectionImagesReceived = receivedImages
                
                print("imagesReceived: \(collectionImagesReceived.count)")
                
            } catch { print("Error in loading pictures from core data")}
        
        
        sections.removeAll(keepingCapacity: false)
        
        var allDiscs: [Discs] = []


        for (num,element) in collectionImagesReceived.enumerated() {
            
                    var _imageData = UIImage()
                        if element.imageData != nil {
                            _imageData = UIImage(data: element.imageData! as Data, scale: 1)!
                        }
            
                    let _imageName = element.discName
                    let _imageDescription = element.discDescription
                    let _discType = element.discType
                    let _imageId = element.id
                    let index = num
                    let disc = Discs(_image: _imageData, _name: _imageName!, _description: _imageDescription!, _type: _discType!, _id: _imageId, _index: index)
            
                    if !sections.contains(_discType!) {
                        sections.append(_discType!)
                        print("sections: \(sections)")
                    }
                    allDiscs.append(disc)
            
            }
            discs = allDiscs
            return allDiscs
        }
        return []
    }
    
    
    
    
     func absoluteIndexForIndexPath(_ indexPath: IndexPath) -> Int {
        var index = 0
        for i in 0..<indexPath.section {
            index += numberOfDiscsInSection(i)
        }
        index += indexPath.item
        return index
    }
    
    
    
    func indexPathForDisc(_ disc: Discs) -> IndexPath {
        let section = sections.index(of: disc.type)!
        var item = 0
        for (index, currentType) in discsForSection(section).enumerated() {
            if currentType === disc {
                item = index
                break
            }
        }
        return IndexPath(item: item, section: section)
    }
    

    
    
    
    
    func numberOfDiscsInSection(_ index: Int) -> Int {
        let discTypes = discsForSection(index)
        return discTypes.count
    }
    
    
    
    func discsForSection(_ index: Int) -> [Discs] {
        let section = sections[index]
        let discsInSection = discs.filter { (disc: Discs) -> Bool in
            return disc.type == section
        }
        
        print("ParksInSection: \(discsInSection)")
        return discsInSection
    }
    
    
    

}

    
    
 

    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    







    
    
    
    

