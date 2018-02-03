//
//  CollectViewImages+CoreDataProperties.swift
//  
//
//  Created by User on 1/30/18.
//
//

import Foundation
import CoreData


extension CollectViewImages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CollectViewImages> {
        return NSFetchRequest<CollectViewImages>(entityName: "CollectViewImages")
    }

    @NSManaged public var id: Double
    @NSManaged public var imageData: NSData?
    @NSManaged public var discType: String?
    @NSManaged public var discDescription: String?
    @NSManaged public var discName: String?

}
