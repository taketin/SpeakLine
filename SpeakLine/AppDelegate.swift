//
//  AppDelegate.swift
//  SpeakLine
//
//  Created by Takeshita Hidenori on 2015/05/25.
//  Copyright (c) 2015年 taketin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var mainWindowController: MainWindowController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let mainWindowController = MainWindowController()
        mainWindowController.showWindow(self)

        self.mainWindowController = mainWindowController
    }
}

