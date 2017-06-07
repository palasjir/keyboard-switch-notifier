//
//  InputSource.swift
//  Keyboard Switch Notifier
//
//  Created by Jiří Palas on 07.06.17.
//  Copyright © 2017 Jiří Palas. All rights reserved.
//

import Cocoa
import Carbon

class InputSource {
    
    var icon: NSImage? = nil
    let source = TISCopyCurrentKeyboardLayoutInputSource().takeRetainedValue()
    
    static func getProperty<T>(_ source: TISInputSource, _ key: CFString) -> T? {
        let cfType = TISGetInputSourceProperty(source, key)
        if (cfType != nil) {
            return Unmanaged<AnyObject>.fromOpaque(cfType!).takeUnretainedValue() as? T
        } else {
            return nil
        }
    }
    
    func getName() -> String {
        return InputSource.getProperty(source, kTISPropertyLocalizedName)!
    }
    
    func getIcon() -> NSImage {
        let imageURL: URL? = InputSource.getProperty(source, kTISPropertyIconImageURL)
        if imageURL != nil {
            self.icon = NSImage(contentsOf: getRetinaImageURL(imageURL!))
            if self.icon == nil {
                self.icon = NSImage(contentsOf: getTiffImageURL(imageURL!))
                if self.icon == nil {
                    self.icon = NSImage(contentsOf: imageURL!)
                }
            }
        } else {
            let iconRef: IconRef? = OpaquePointer(TISGetInputSourceProperty(source, kTISPropertyIconRef))
            if iconRef != nil {
                self.icon = NSImage(iconRef: iconRef!)
            }
        }
        return self.icon!
    }
    
    func getRetinaImageURL(_ path: URL) -> URL {
        var components = path.pathComponents
        let filename: String = components.removeLast()
        let ext: String = path.pathExtension
        let retinaFilename = filename.replacingOccurrences(of: "." + ext, with: "@2x." + ext)
        return NSURL.fileURL(withPathComponents: components + [retinaFilename])!
    }
    
    func getTiffImageURL(_ path: URL) -> URL {
        return path.deletingPathExtension().appendingPathExtension("tiff")
    }
    
}
