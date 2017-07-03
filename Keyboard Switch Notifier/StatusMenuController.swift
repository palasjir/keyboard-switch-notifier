//
//  StatusMenuController.swift
//  Keyboard Switch Notifier
//
//  Created by Jiří Palas on 07.06.17.
//  Copyright © 2017 Jiří Palas. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var launchAtStartUpItem: NSMenuItem!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let launchAtStartupHandler = LaunchAtStartupHandler()
    
    override func awakeFromNib() {
        let icon = NSImage(named: "statusMenu")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        if PreferenceManager.instance.startAtLogin {
            launchAtStartUpItem.state = NSOnState
        } else {
            launchAtStartUpItem.state = NSOffState
        }
        
    }

    @IBAction func launchAtStartupClicked(_ sender: Any) {
        print("launchAtStartup")
         launchAtStartupHandler.handle(menuItem: launchAtStartUpItem)
    }

    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared().terminate(self)
    }
}
