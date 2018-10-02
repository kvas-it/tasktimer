//
//  CountdownTimer.swift
//  tasktimer
//
//  Created by Vasily Kuznetsov on 02/10/18.
//  Copyright © 2018 Vasily Kuznetsov. All rights reserved.
//

import Foundation

class CountdownTimer {

    var remaining = 0
    var updateCallback: (Int) -> Void = {_ in }
    lazy var timer = Timer()

    func setUpdateCallback(callback: @escaping (Int) -> Void) {
        updateCallback = callback
    }

    func start(minutes: Int) {
        stop()
        remaining = minutes * 60
        updateCallback(remaining)
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(CountdownTimer.tick),
            userInfo: nil,
            repeats: true
        )
    }

    func stop() {
        remaining = 0
        timer.invalidate()
        updateCallback(remaining)
    }

    func adjust(minutes: Int) {
        if remaining == 0 {
            if minutes > 0 {
                start(minutes: minutes)
            }
        } else {
            remaining += minutes * 60
            updateCallback(remaining)
        }
    }

    @objc func tick() {
        remaining -= 1
        if (remaining <= 0) {
            stop()
        }
        updateCallback(remaining)
    }
}
