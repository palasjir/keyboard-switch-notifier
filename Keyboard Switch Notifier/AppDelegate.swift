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
    
    let nc = NotificationCenter.default
    let unc = NSUserNotificationCenter.default

    func applicationDidFinishLaunching(_ aNotification: Notification) {
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
    
    func handleNotif(sender: AnyObject) {
        let ins = InputSource()
        let notif = KeyboardChangedNotification(name: ins.getName(), icon: ins.getIcon())
        unc.deliver(notif)
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }

}

