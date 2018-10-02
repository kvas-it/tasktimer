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
    @IBOutlet weak var intervalSlider: NSSlider!
    @IBOutlet weak var timerInterval: NSMenuItem!

    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    var timer = CountdownTimer();
    var interval = 0;

    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }

    @IBAction func sliderChanged(_ sender: NSSlider) {
        let minutes = Int(pow(8.0, sender.doubleValue) * 12.5)
        interval = minutes * 60
        if (minutes == 1) {
            timerInterval.title = "Set timer for one minute"
        } else {
            timerInterval.title = "Set timer for " + String(minutes) + " minutes"
        }
    }

    @IBAction func startClicked(_ sender: NSMenuItem) {
        if (interval == 60) {
            interval = 5
        }
        timer.start(interval: interval, callback: {self.updateRemaining(seconds: $0)})
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
        intervalSlider.setFrameSize(NSSize(width: 300, height: 25))
        intervalSlider.minValue = -1.0
        intervalSlider.maxValue = 1.0
        intervalSlider.doubleValue = 0.35 // 25 minutes
        sliderChanged(intervalSlider)
    }

}
