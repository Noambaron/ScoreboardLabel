//
//  Extensions.swift
//  ScoreboardLabel
//
//  Created by Noam on 9/30/15.
//  Copyright (c) 2015 Noam. All rights reserved.
//

import Foundation

extension Array {
    
    // Safely lookup an index that might be out of bounds,
    // returning nil if it does not exist
    func get(index: Int) -> Element? {
        if 0 <= index && index < count {
            return self[index]
        } else {
            return nil
        }
    }
}


extension String {
    func Letterize() -> [String] {
        return self.characters.map { String($0) }
    }
}

public func performThisAfter(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

