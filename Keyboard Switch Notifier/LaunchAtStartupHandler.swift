//
//  LaunchAtStartupHandler.swift
//  Keyboard Switch Notifier
//
//  Created by Jiří Palas on 03.07.17.
//  Copyright © 2017 Jiří Palas. All rights reserved.
//

import Cocoa
import ServiceManagement

class LaunchAtStartupHandler : NSObject {
    
    let appBundleIdentifier = "com.palasjiri.KeyboardSwitchNotifierHelper"
    
    func isAutoLunchEnabled(menuItem: NSMenuItem) -> Bool {
        if(menuItem.state == NSOffState) {
            return true
        } else {
            return false
        }
    }
    
    func setStartAtLogin(state: Bool) {
        PreferenceManager.instance.startAtLogin = state
    }
    
    func handle(menuItem: NSMenuItem) {
        let autoLaunch = isAutoLunchEnabled(menuItem: menuItem)
        if SMLoginItemSetEnabled(appBundleIdentifier as CFString, autoLaunch) {
            if autoLaunch {
                NSLog("Successfully add login item.")
                menuItem.state = NSOnState
                
            } else {
                NSLog("Successfully remove login item.")
                menuItem.state = NSOffState
            }
            setStartAtLogin(state: autoLaunch)
        } else {
            NSLog("Failed to add login item.")
        }
    }
}

