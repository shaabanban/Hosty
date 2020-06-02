//
//  HostEntry.swift
//  Hosty
//
//  Created by Ahmed Shaaban on 6/1/20.
//  Copyright © 2020 Shaabs. All rights reserved.
//

import Foundation

// just make it easy to go back and forth between a struct and a string
struct HostEntry: ExpressibleByStringLiteral, CustomStringConvertible {
    var ip: String;
    var hosts: [String]
    var enabled: Bool;
    var description: String {
        return "\(enabled ? "": "#") \(ip)\t\(hosts.joined(separator: "\t"))"
   }
    
    init(_ string: String){
        var trimmedString = string.trimmingCharacters(in: .whitespaces);
        // if the start of the line is a # then its disabled
        self.enabled = !trimmedString.hasPrefix("#");
        
        // remove the comment text from the beginning if its there
        trimmedString = trimmedString.trimmingCharacters(in: ["#"]);
        
        let strArry = trimmedString.components(separatedBy: CharacterSet(charactersIn: "\t ")).filter { (s: String) -> Bool in
            let trimmed = s.trimmingCharacters(in: .whitespaces);
            return trimmed.count > 0
        };
        
        if(strArry.count == 0) {
            self.ip = ""
            self.hosts = [];
            return;
        }
        
        self.ip = strArry[0];
        self.hosts = Array(strArry[1...])
        
    }
    
    init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
    
    init(unicodeScalarLiteral value: String) {
        self.init(value)
    }
    
    init(stringLiteral value: String) {
        self.init(value)
    }
}
