//
//  Int+Extensions.swift
//  iMusicTask
//
//  Created by Vahe Hakobyan on 19.05.22.
//

import Foundation

extension Int {
    
    /// Converts number to time representation
    func secondsToTime(autohideHour: Bool = true) -> String {
        let (h, m, s) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
        
        var components = [String]()
        if !autohideHour || h > 0 {
            components.append(h < 10 ? "0\(h)" : "\(h)")
        }
        components.append(m < 10 ? "0\(m)" : "\(m)")
        components.append(s < 10 ? "0\(s)" : "\(s)")
        
        return components.joined(separator: ":")
    }
    
}
