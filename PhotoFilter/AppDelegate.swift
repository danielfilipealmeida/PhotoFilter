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
        }
        
        // sets up the filter
        let filter  = CIFilter(name: "CISepiaTone")
        filter?.setValue(project.getImage(), forKey: kCIInputImageKey)
        filter?.setValue(2, forKey: "inputIntensity")
        let filterAttributes = filter?.attributes
        print(filterAttributes ?? "")
        
        // filter the image
        let result: CIImage = filter?.value(forKey: kCIOutputImageKey) as! CIImage
        
        self.imageView.image = NSImagefromCIImage(result)
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func CIImageFromNSImage(_ nsImage:NSImage) -> CIImage? {
        guard let tiffData = nsImage.tiffRepresentation else { return nil }
        guard let bitmap = NSBitmapImageRep(data:tiffData) else { return nil }
        
        return CIImage(bitmapImageRep: bitmap)
    }
    
    /**
     Creates a NSImage from a CIImage
     
     -Parameter ciImage: the input image in CIImage object
     
     -Returns: a equivalent NSImage object
     */
    func NSImagefromCIImage(_ ciImage:CIImage) -> NSImage? {
        let rep = NSCIImageRep(ciImage: ciImage)
        let nsImage =  NSImage(size: rep.size)
        nsImage.addRepresentation(rep)
        
        return nsImage
    }

}

