//
//  KeyboardChangedNotification.swift
//  Keyboard Switch Notifier
//
//  Created by Jiří Palas on 07.06.17.
//  Copyright © 2017 Jiří Palas. All rights reserved.
//

import Cocoa

class KeyboardChangedNotification: NSUserNotification {
    
    init(name:String, icon: NSImage) {
        super.init()
        self.title = "Keyboard changed"
        self.subtitle = name
        self.contentImage = icon
    }

}
