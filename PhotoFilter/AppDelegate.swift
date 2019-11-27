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
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let image = NSImage(named: "photo.jpg")
        
        let ciImage = CIImageFromNSImage(image!)
        
        
        self.imageView.image = NSImagefromCIImage(ciImage!)
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

