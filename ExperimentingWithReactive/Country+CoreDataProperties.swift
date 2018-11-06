//
//  Country+CoreDataProperties.swift
//  
//
//  Created by manoj.gubba on 2018/11/05.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

}
