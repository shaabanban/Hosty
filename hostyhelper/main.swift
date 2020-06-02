//
//  main.swift
//  hostyhelper
//
//  Created by Ahmed Shaaban on 6/1/20.
//  Copyright © 2020 Golden Chopper. All rights reserved.
//

import Foundation

print("Hello, World!")

let str = "#[Hosty Group yabba] \n # \t   192.168.1.1   localhost  flarp  \n  192.168.1.1   localhost  flarp \n #[End Hosty Group]\n";

print(try! HostGroup(str))
//let data = try String(contentsOfFile: "/etc/hosts", encoding: .utf8) + "\n test";
//let url = URL(fileURLWithPath: "/etc/hosts")
//try data.write(to: url, atomically: true, encoding: .utf8)
