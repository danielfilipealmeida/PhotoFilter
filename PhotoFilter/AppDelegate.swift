//
//  AppDelegate.swift
//  PhotoFilter
//
//  Created by Daniel Almeida on 26/11/2019.
//  Copyright © 2019 Daniel Almeida. All rights reserved.
//

import Cocoa
import CoreImage


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var imageView: NSImageView!
    
    var project: Project
    
    override init() {
        self.project = Project()
        super.init()
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let path = Bundle.main.path(forResource: "photo", ofType: "jpg")!
        
        do {
            try project.loadImage(path: path)
        }
        catch {
            print ("Error loading Image")
            return
        }
        
        // filter 1
        project.addFilter(filterName: "CISepiaTone")
        project.setFilterValueForKey(index: 0, value: 2, key: "inputIntensity")
        
        // filter 2
        project.addFilter(filterName: "CIGaussianBlur")
        project.setFilterValueForKey(index: 1, value: 2, key: "inputRadius")
        
        // filter 3
        project.addFilter(filterName: "CIColorInvert")
        
        self.imageView.image =  NSImagefromCIImage(project.getFilteredImage())
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    /**
     Convert NSImage to CIImage.
     
     - parameter nsImage: the input image
     
     - returns: an equivalent CIImage
     
     - TODO: move to a tools class
     */
    func CIImageFromNSImage(_ nsImage:NSImage) -> CIImage? {
        guard let tiffData = nsImage.tiffRepresentation else { return nil }
        guard let bitmap = NSBitmapImageRep(data:tiffData) else { return nil }
        
        return CIImage(bitmapImageRep: bitmap)
    }
    
    /**
     Creates a NSImage from a CIImage
     
     - Parameter ciImage: the input image in CIImage object
     
     - Returns: a equivalent NSImage object
     
     - TODO: move to a tools class
     */
    func NSImagefromCIImage(_ ciImage:CIImage) -> NSImage? {
        let rep = NSCIImageRep(ciImage: ciImage)
        let nsImage =  NSImage(size: rep.size)
        nsImage.addRepresentation(rep)
        
        return nsImage
    }

}

