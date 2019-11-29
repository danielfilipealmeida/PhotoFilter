//
//  Project.swift
//  PhotoFilter
//
//  Created by Daniel Almeida on 28/11/2019.
//  Copyright © 2019 Daniel Almeida. All rights reserved.
//

import Cocoa
import CoreImage

enum ProjectError: Error {
    case noUrl
    case nsimageToRepresentationFailed
    case representationToBitmapFailed
}

class Project: NSObject {
    private var image: CIImage
    private var path: String
    private var filters:NSMutableArray
    
    /**
     Initializer
     */
    override init() {
        self.path = ""
        self.image = CIImage()
        self.filters = NSMutableArray()
    }
    
    /**
     Loads an image stored locally
     
     - parameter path: a string with the full path to an image
     */
    public func loadImage(path: String) throws {
        self.path = path;
        
        let image = NSImage(contentsOfFile: path)
        
        guard let tiffData = image?.tiffRepresentation else {
            throw ProjectError.nsimageToRepresentationFailed
        }
        
        guard let bitmap = NSBitmapImageRep(data:tiffData) else {
            throw ProjectError.representationToBitmapFailed
        }
        
        self.image = CIImage(bitmapImageRep: bitmap)!
    }
    
    /**
    Loads an image through an URL.
     
     - parameter url: the  url pointing to the image
     */
    public func loadImage(url: URL) throws {
        let path = url.absoluteString
        try self.loadImage(path: path)
    }
    
    /**
     Returns the input image
     
     - returns: the input image in CIImage format
     */
    func getImage() -> CIImage {
        return self.image
    }
    
    /**
     Inserts a filter into the  filters array
     
     - parameter filterName: a string with the name of the new filter
     */
    func addFilter(filterName:String) {
        let filter = CIFilter(name: filterName)
        var filterInput: CIImage
        
        // sets the chaining
        if filters.count == 0 {
            filterInput = self.image
            filter?.setValue(self.image, forKey: kCIInputImageKey)
        }
        else {
            let previousFilter: CIFilter = filters[filters.count - 1] as! CIFilter
            filterInput = previousFilter.value(forKey: kCIOutputImageKey) as! CIImage
            
        }
        filter?.setValue(filterInput, forKey: kCIInputImageKey)
        
        filters.add(filter as Any)
    }
    
    /**
    Sets one filter  parameter  in a filter inside the filter array
     
     - parameter index: the index of the filter in the matrix
     
     - parameter value: the value of the parameter
     
     - parameter key: the name of the parameter
     */
    func setFilterValueForKey(
        index: Int,
        value: Any,
        key: String
    ) {
        let filter:CIFilter = filters[index] as! CIFilter
        
        filter.setValue(value, forKey: key)
    }
    
    /**
     Get the final filtered image
     
     - returns: the  filtered image
     */
    func getFilteredImage() -> CIImage {
        let lastFilter:CIFilter = filters[filters.count - 1] as! CIFilter
        
        return lastFilter.value(forKey: kCIOutputImageKey) as! CIImage
    }
    
    func getFilterAttributesAtIndex(index: Int) {
        
    }
    

}
