//
//  InputSourceObserver.swift
//  Keyboard Switch Notifier
//
//  Created by Jiří Palas on 07.06.17.
//  Copyright © 2017 Jiří Palas. All rights reserved.
//

import Cocoa

class InputSourceObserver: NSObject, NSUserNotificationCenterDelegate {
    
    let name = Notification.Name("NSTextInputContextKeyboardSelectionDidChangeNotification")
    let nc = NotificationCenter.default
    let unc = NSUserNotificationCenter.default
    
    override init() {
        super.init()
        nc.addObserver(
            self,
            selector:#selector(handleNotif(sender:)),
            name: name,
            object: nil)
        unc.delegate = self
    }
    
    func handleNotif(sender: AnyObject) {
        let ins = InputSource()
        let notif = KeyboardChangedNotification(name: ins.getName(), icon: ins.getIcon())
        unc.deliver(notif)
    }
    
    func remove() {
        nc.removeObserver(self)
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
}
