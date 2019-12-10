//
//  FilterWindow.swift
//  PhotoFilter
//
//  Created by Daniel Almeida on 01/12/2019.
//  Copyright © 2019 Daniel Almeida. All rights reserved.
//

import Cocoa

class FilterWindow: NSObject {


    
    var allFilters: [String]

    
    override init() {
        self.allFilters = []
        super.init()
    }
    

    /*
    @IBAction func addFilterButtonClicked(_ sender: Any) {
        if self.allFilters.isEmpty {
            self.allFilters = Filters.getAllFilters()
        }
        
        let menu:NSMenu = NSMenu(title: "ee")
        for filter:String in self.allFilters {
            let menuItem: NSMenuItem = NSMenuItem(title: filter, action: nil, keyEquivalent: "")
            menu.addItem(menuItem)
        }
        
        menu.popUp(positioning: nil, at: NSMakePoint(0, 0), in: view)
    }
    */
}
