//
//  AppDelegate.swift
//  Ambar
//
//  Created by Anagh Sharma on 12/11/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{
    var popover = NSPopover.init()
    var statusBar: StatusBarController?

    // MARK Helper Variables
    private var currentHelperConnection: NSXPCConnection?

    @objc dynamic private var currentHelperAuthData: NSData?
    private let currentHelperAuthDataKeyPath: String

    @objc dynamic private var helperIsInstalled = false
    private let helperIsInstalledKeyPath: String

    override init() {
        self.currentHelperAuthDataKeyPath = NSStringFromSelector(#selector(getter: self.currentHelperAuthData))
        self.helperIsInstalledKeyPath = NSStringFromSelector(#selector(getter: self.helperIsInstalled))
        super.init()
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        
        // Create the SwiftUI view that provides the contents
        let contentView = ContentView()

        // Set the SwiftUI's ContentView to the Popover's ContentViewController
        popover.contentViewController = MainViewController()
        popover.contentSize = NSSize(width: 500, height: 360)
        popover.contentViewController?.view = NSHostingView(rootView: contentView)
        
        // Create the Status Bar Item with the Popover
        statusBar = StatusBarController.init(popover)
    }

    func applicationWillTerminate(_ aNotification: Notification)
    {
        // Insert code here to tear down your application
    }
    
    
}


struct AppDelegate_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
