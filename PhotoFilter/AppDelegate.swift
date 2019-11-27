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
        self.imageView.image = image
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

