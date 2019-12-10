//
//  Filters.swift
//  PhotoFilter
//
//  Created by Daniel Almeida on 30/11/2019.
//  Copyright © 2019 Daniel Almeida. All rights reserved.
//

import Cocoa

class Filters: NSObject {

    /**
     Get an array with all filter codes
     - Returns: an array
     */
    static func getAllFilters() -> [String] {
        return CIFilter.filterNames(inCategory: nil)
    }
    
    /**
     Get an array with all filter  category codes
     - Returns: an array
     */
    static func getAllCategories() ->  [String] {
        let allFilterNames: [String] = Filters.getAllFilters()
        
        return allFilterNames.map {
            let filter = CIFilter(name: $0)
            
            return filter?.value(forKey: kCIAttributeFilterCategories) as! String
        }
    }
}
