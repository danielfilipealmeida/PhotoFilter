//
//  FiltersWindow.swift
//  PhotoFilter
//
//  Created by Daniel Almeida on 10/12/2019.
//  Copyright © 2019 Daniel Almeida. All rights reserved.
//

import Cocoa

class FiltersWindow: NSObject {
    @IBOutlet var window: NSWindow!
    @IBOutlet weak var addButton: NSButton!
    
    var allFilters:  [String]
    
    override init() {
        allFilters = Filters.getAllFilters()
        super.init()
        
        self.loadWindowFromXib()
    }
    
    func loadWindowFromXib() {
        var topLevelObjects: NSArray?
        if Bundle.main.loadNibNamed("FiltersWindow", owner: self, topLevelObjects: &topLevelObjects) {
            window = topLevelObjects!.first(where: {$0 is NSWindow}) as? NSWindow
            window.display()
        }
    }
    
    @IBAction func addButtonClick(_ sender: Any) {
    }
}
