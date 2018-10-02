//
//  StatusMenuController.swift
//  tasktimer
//
//  Created by Vasily Kuznetsov on 02/10/18.
//  Copyright © 2018 Vasily Kuznetsov. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {

    @IBOutlet weak var statusMenu: NSMenu!

    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    var timer = CountdownTimer();

    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    @IBAction func startFive(_ sender: NSMenuItem) {
        timer.start(minutes: 5)
    }

    @IBAction func startTen(_ sender: NSMenuItem) {
        timer.start(minutes: 10)
    }

    @IBAction func startTwentyFive(_ sender: NSMenuItem) {
        timer.start(minutes: 25)
    }

    @IBAction func startFortyFive(_ sender: NSMenuItem) {
        timer.start(minutes: 45)
    }

    @IBAction func minusFive(_ sender: NSButton) {
        timer.adjust(minutes: -5)
    }

    @IBAction func minusOne(_ sender: NSButton) {
        timer.adjust(minutes: -1)
    }

    @IBAction func plusFive(_ sender: NSButton) {
        timer.adjust(minutes: 5)
    }

    @IBAction func plusOne(_ sender: NSButton) {
        timer.adjust(minutes: 1)
    }

    @IBAction func cancelTimer(_ sender: NSMenuItem) {
        timer.stop()
    }

    func updateRemaining(seconds: Int) {
        if (seconds == 0) {
            statusItem.title = ""
        } else {
            let m = seconds / 60
            let s = seconds % 60
            statusItem.title = String(format: "%d:%02d  ", m, s)
        }
    }

    override func awakeFromNib() {
        let icon = NSImage(named: "StatusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
        timer.setUpdateCallback(callback: {self.updateRemaining(seconds: $0)})
    }

}
