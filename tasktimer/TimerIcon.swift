//
//  TimerIcon.swift
//  tasktimer
//
//  Created by Vasily Kuznetsov on 03/10/18.
//  Copyright © 2018 Vasily Kuznetsov. All rights reserved.
//

import Cocoa

class TimerIcon: NSImage {

    static let origin = NSPoint.init(x: 0, y: 0)
    static let center = NSPoint.init(x: 8, y: 8)
    static let iconSize = NSSize(width: 16, height: 16)
    static let bboxPath = NSBezierPath.init(
        rect: NSRect.init(origin: origin, size: iconSize)
    )
    static let facePath = { () -> NSBezierPath in 
        let fp = NSBezierPath(
            ovalIn: NSRect.init(x: 0.5, y: 0.5, width: 15, height: 15)
        )
        fp.appendOval(
                in: NSRect.init(x: 7, y: 7, width: 2, height: 2)
        )
        return fp;
    }()
    static let handPath = { () -> NSBezierPath in
        let hp = NSBezierPath()
        hp.move(to: TimerIcon.center)
        hp.line(to: NSPoint.init(x: 15, y: 8))
        return hp
    }()

    convenience init() {
        self.init(size: TimerIcon.iconSize)
        self.isTemplate = true // best for dark mode
    }

    private func startDrawing() {
        lockFocusFlipped(true)
        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current()?.cgContext.setBlendMode(CGBlendMode.clear)
        TimerIcon.bboxPath.fill()
        NSGraphicsContext.current()?.cgContext.setBlendMode(CGBlendMode.normal)
        TimerIcon.facePath.stroke()
    }

    private func endDrawing() {
        NSGraphicsContext.restoreGraphicsState()
        unlockFocus()
    }
    
    func setOff() {
        startDrawing()
        TimerIcon.handPath.stroke()
        endDrawing()
    }

    func setOn(ratio: Double) {
        startDrawing()
        let pie = NSBezierPath.init()
        pie.move(to: TimerIcon.center)
        pie.appendArc(
            withCenter: TimerIcon.center,
            radius: 8,
            startAngle: CGFloat(270 - 360 * ratio),
            endAngle: 270
        )
        pie.line(to: TimerIcon.center)
        pie.fill()
        endDrawing()
    }
}
