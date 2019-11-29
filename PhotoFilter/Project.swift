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
    private var filters:NSArray
    
    /**
     Initializer
     */
    override init() {
        self.path = ""
        self.image = CIImage()
        self.filters = NSArray()
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
    
    func addFilter(filterName:NSString) {
        
    }
    
    func getFilterAttributesAtIndex(index: Int) {
        
    }
    
    func getImage() -> CIImage {
        return self.image
    }
}
