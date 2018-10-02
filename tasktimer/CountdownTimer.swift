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

    func start(interval: Int, callback: @escaping (Int) -> Void) {
        timer.invalidate()
        remaining = interval
        updateCallback = callback
        updateCallback(remaining)
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(CountdownTimer.tick),
            userInfo: nil,
            repeats: true
        )
    }

    @objc func tick() {
        remaining -= 1
        updateCallback(remaining)
        if (remaining <= 0) {
            timer.invalidate()
        }
    }
}
