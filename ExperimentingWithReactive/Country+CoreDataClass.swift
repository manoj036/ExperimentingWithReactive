//
//  Country+CoreDataClass.swift
//  
//
//  Created by manoj.gubba on 2018/11/05.
//
//

import Foundation
import CoreData


public class Country: NSManagedObject {
    
    @NSManaged public var name: String?
    @NSManaged public var vat: Float
    
}
