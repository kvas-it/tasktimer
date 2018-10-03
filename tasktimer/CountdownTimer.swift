//
//  CountdownTimer.swift
//  tasktimer
//
//  Created by Vasily Kuznetsov on 02/10/18.
//  Copyright © 2018 Vasily Kuznetsov. All rights reserved.
//

import Foundation

class CountdownTimer {

    var end = 0
    var total = 0
    var updateCallback: (Int, Double) -> Void = {_ in }
    lazy var timer = Timer()

    func setUpdateCallback(callback: @escaping (Int, Double) -> Void) {
        updateCallback = callback
    }

    func start(minutes: Int) {
        stop()
        total = minutes * 60
        let time = Int(Date().timeIntervalSince1970)
        end = time + total
        tick()
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(CountdownTimer.tick),
            userInfo: nil,
            repeats: true
        )
    }

    func stop() {
        end = 0
        total = 0
        timer.invalidate()
        tick()
    }

    func adjust(minutes: Int) {
        if end == 0 {
            if minutes > 0 {
                start(minutes: minutes)
            }
        } else {
            let seconds = minutes * 60
            end += seconds
            total += seconds
            tick()
        }
    }

    @objc func tick() {
        let now = Int(Date().timeIntervalSince1970)
        let remaining = max(end - now, 0)
        let ratio = total == 0 ? 0 : Double(remaining) / Double(total)
        if remaining == 0 && end != 0 {
            stop()
        }
        updateCallback(remaining, ratio)
    }
}
