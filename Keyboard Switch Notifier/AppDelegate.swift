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
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var observer: InputSourceObserver? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        observer = InputSourceObserver()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        observer?.remove()
    }

}

