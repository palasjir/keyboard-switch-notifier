//
//  AppDelegate.swift
//  Keyboard Switch Notifier
//
//  Created by Jiří Palas on 04.06.17.
//  Copyright © 2017 Jiří Palas. All rights reserved.
//
import Cocoa
import Carbon

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSUserNotificationCenterDelegate {
    
    let statusItem = NSStatusBar.system().statusItem(withLength: -2)
    let myNotification = Notification.Name(rawValue:"MyNotification")
    
    let nc = NotificationCenter.default
    let unc = NSUserNotificationCenter.default

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        initUI()
        nc.addObserver(
            self,
            selector:#selector(handleNotif(sender:)),
            name: Notification.Name("NSTextInputContextKeyboardSelectionDidChangeNotification"),
            object: nil)
        
        unc.delegate = self
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        nc.removeObserver(self)
    }
    
    func initUI() {
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
        }
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: ""))
        statusItem.menu = menu
    }
    
    func quit(sender : NSMenuItem) {
        NSApp.terminate(self)
    }
    
    func handleNotif(sender: AnyObject) {
        let ins = getInputSource()
        let notification = createInputSourceChangedNotification(keyboardName: ins)
        unc.deliver(notification)
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
    func getInputSource() -> String? {
        let source = TISCopyCurrentKeyboardLayoutInputSource().takeRetainedValue()
        // some others ?
        // kTISPropertyInputSourceID
        // kTISPropertyUnicodeKeyLayoutData
        guard let ptr = TISGetInputSourceProperty(source, kTISPropertyLocalizedName) else {
            NSLog("Could not get keyboard localized name.")
            return nil
        }
        return Unmanaged<CFString>.fromOpaque(ptr).takeRetainedValue() as String
    }
    
    
    func createInputSourceChangedNotification(keyboardName: String?) -> NSUserNotification {
        let notification:NSUserNotification = NSUserNotification()
        notification.title = "Keyboard changed"
        notification.subtitle = keyboardName ?? "Unknown"
        return notification
    }

}

