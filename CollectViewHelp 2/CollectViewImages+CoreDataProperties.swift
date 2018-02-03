//
//  CollectViewImages+CoreDataProperties.swift
//  CollectViewHelp
//
//  Created by User on 2/2/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//
//

import Foundation
import CoreData


extension CollectViewImages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CollectViewImages> {
        return NSFetchRequest<CollectViewImages>(entityName: "CollectViewImages")
    }

    @NSManaged public var discName: String?
    @NSManaged public var discDescription: String?
    @NSManaged public var discType: String?
    @NSManaged public var id: Double
    @NSManaged public var imageData: NSData?

}
