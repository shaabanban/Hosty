//
//  AppProtocol.swift
//  Hosty
//
//  Created by Ahmed Shaaban on 6/1/20.
//  Copyright © 2020 Golden Chopper. All rights reserved.
//

import Foundation

@objc(HelperProtocol)
protocol HelperProtocol {
    func getVersion(completion: @escaping (String) -> Void)
    func readHostsFile(completion: @escaping (NSString) -> Void)
    func writeHostsFile( fileContents: NSString, completion: @escaping (NSNumber) -> Void)
}
