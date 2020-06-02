//
//  HostGroup.swift
//  Hosty
//
//  Created by Ahmed Shaaban on 6/1/20.
//  Copyright © 2020 Shaabs. All rights reserved.
//

import Foundation

enum HostGroupError: Error {
    case runtimeError(String)
}

struct HostGroup: CustomStringConvertible{
    var name: String;
    var entries: [HostEntry]
    
    var description: String {
        var str = "#[Hosty Group \(self.name)] \n"
        for entry in entries {
            str.append(entry.description + "\n")
        }
        str.append("#[End Hosty Group]\n")
        return str;
    }
     
     init(_ string: String) throws {
        var lines = string.split(separator: "\n").filter { (str: Substring) -> Bool in
            // remove empty lines
            str.trimmingCharacters(in: .whitespaces).count > 0
        }
        
        if(lines.count < 2) {
            // needs to be at least 
            throw HostGroupError.runtimeError("Corrupt hosty group entry! There must be at least 2 lines in a hosty group")
        }
        
        if(!lines[0].trimmingCharacters(in: .whitespaces).hasPrefix("#[Hosty Group")
            || !lines[lines.count - 1].trimmingCharacters(in: .whitespaces).hasPrefix("#[End Hosty Group]")
            ) {
            throw HostGroupError.runtimeError("Corrupt hosty group entry! Hosty entries should start with and be terminated properly!")
        }
        
        self.entries = lines[1..<lines.count-1].map({ HostEntry(String($0))})
        
        // Thanks https://whatdidilearn.info/2018/07/29/how-to-capture-regex-group-values-in-swift.html
        let regex = try? NSRegularExpression(
          pattern: "\\#\\[Hosty Group(?<name>.*)\\]",
          options: .caseInsensitive
        )
        if let match = regex?.firstMatch(in: String(lines[0]), options: [], range: NSRange(location: 0, length: lines[0].utf16.count)) {
            if let nameRange = Range(match.range(withName: "name"), in: lines[0]) {
                self.name = String(lines[0][nameRange])
                return;
            }
        }
        self.name = ""
     }
     
}
