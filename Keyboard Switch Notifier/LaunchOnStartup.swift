//
//  LaunchOnStartup.swift
//  Keyboard Switch Notifier
//
//  Created by Jiří Palas on 06.06.17.
//  Copyright © 2017 Jiří Palas. All rights reserved.
//

import Foundation
import Cocoa

class LaunchOnStartup {
    static func itemReferencesInLoginItems() -> (existingReference: LSSharedFileListItem?, lastReference: LSSharedFileListItem?) {
        let appUrl = URL(fileURLWithPath: Bundle.main.bundlePath)
        let loginItemsRef = LSSharedFileListCreate(
            nil,
            kLSSharedFileListSessionLoginItems.takeRetainedValue(),
            nil
            ).takeRetainedValue() as LSSharedFileList?
        if loginItemsRef != nil {
            let loginItems = LSSharedFileListCopySnapshot(loginItemsRef, nil).takeRetainedValue() as Array
            
            if loginItems.count == 0 {
                return (nil, kLSSharedFileListItemBeforeFirst.takeRetainedValue())
            }
            
            let lastItemRef: LSSharedFileListItem = loginItems.last as! LSSharedFileListItem
            
            for currentItemRef in loginItems as! [LSSharedFileListItem] {
                if let itemUrl = LSSharedFileListItemCopyResolvedURL(currentItemRef, 0, nil) {
                    if (itemUrl.takeRetainedValue() as URL) == appUrl {
                        return (currentItemRef, lastItemRef)
                    }
                }
            }
            
            return (nil, lastItemRef)
        }
        return (nil, nil)
    }
    
    static func toggleLaunchAtLogin(_ shouldLaunch: Bool) {
        if toggleOpenAppLogin.selectedSegment == 0 {
            if !SMLoginItemSetEnabled(NCConstants.launcherApplicationIdentifier as CFString, true) {
                print("The login item was not successfull")
                toggleOpenAppLogin.setSelected(true, forSegment: 1)
            }
            else {
                UserDefaults.standard.set("true", forKey: "appLoginStart")
            }
        }
        else {
            if !SMLoginItemSetEnabled(NCConstants.launcherApplicationIdentifier as CFString, false) {
                print("The login item was not successfull")
                toggleOpenAppLogin.setSelected(true, forSegment: 0)
            }
            else {
                UserDefaults.standard.set("false", forKey: "appLoginStart")
            }
        }
    }
}
