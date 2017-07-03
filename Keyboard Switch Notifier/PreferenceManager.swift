//
//  PreferenceManager.swift
//  Keyboard Switch Notifier
//
//  Created by Jiří Palas on 03.07.17.
//  Copyright © 2017 Jiří Palas. All rights reserved.
//
import Foundation

class PreferenceManager {
    
    // Single instance
    static let instance = PreferenceManager()
    
    private init() {
        registerFactoryDefaults()
    }
    
    let userDefaults = UserDefaults.standard
    
    private let startAtLoginKey = "Start At Login"
    
    var startAtLogin: Bool {
        get {
            return userDefaults.bool(forKey: startAtLoginKey)
        }
        
        set {
            userDefaults.set(newValue, forKey: startAtLoginKey)
        }
    }
    
    private func registerFactoryDefaults() {
        let factoryDefaults = [
            startAtLoginKey: NSNumber(value: false),
            ]
        userDefaults.register(defaults: factoryDefaults)
    }
    
    func synchronize() {
        userDefaults.synchronize()
    }
    
    func reset() {
        userDefaults.removeObject(forKey: startAtLoginKey)
        synchronize()
    }
}
