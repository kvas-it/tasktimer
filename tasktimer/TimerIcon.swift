//
//  TimerIcon.swift
//  tasktimer
//
//  Created by Vasily Kuznetsov on 03/10/18.
//  Copyright © 2018 Vasily Kuznetsov. All rights reserved.
//

import Cocoa

class TimerIcon: NSImage {

    convenience init() {
        self.init(size: NSSize(width: 16, height: 16))
        self.isTemplate = true // best for dark mode
    }

    func setOff() {
        self.lockFocusFlipped(true)
        let gctx = NSGraphicsContext.current()
        gctx?.saveGraphicsState()
        gctx?.shouldAntialias = true
        gctx?.cgContext.setBlendMode(CGBlendMode.clear)
        NSBezierPath.init(rect: NSRect.init(x: 0, y: 0, width: 16, height: 16)).fill()
        gctx?.cgContext.setBlendMode(CGBlendMode.normal)
        let center = NSPoint.init(x: 8, y: 8)
        let path = NSBezierPath(ovalIn: NSRect.init(x: 0.5, y: 0.5, width: 15, height: 15))
        path.move(to: center)
        path.line(to: NSPoint.init(x: 8, y: 1))
        path.appendOval(in: NSRect.init(x: 7, y: 7, width: 2, height: 2))
        path.stroke()
        gctx?.restoreGraphicsState()
        self.unlockFocus()
    }

    func setOn(ratio: Double) {
        self.lockFocusFlipped(true)
        let gctx = NSGraphicsContext.current()
        gctx?.saveGraphicsState()
        gctx?.shouldAntialias = true
        gctx?.cgContext.setBlendMode(CGBlendMode.clear)
        NSBezierPath.init(rect: NSRect.init(x: 0, y: 0, width: 16, height: 16)).fill()
        gctx?.cgContext.setBlendMode(CGBlendMode.normal)
        let center = NSPoint.init(x: 8, y: 8)
        let circle = NSBezierPath(ovalIn: NSRect.init(x: 0.5, y: 0.5, width: 15, height: 15))
        circle.appendOval(in: NSRect.init(x: 7, y: 7, width: 2, height: 2))
        circle.stroke()
        let pie = NSBezierPath.init()
        pie.move(to: center)
        pie.appendArc(
            withCenter: center,
            radius: 8,
            startAngle: CGFloat(360 * ratio - 90.0),
            endAngle: 270
        )
        pie.line(to: center)
        pie.fill()
        gctx?.restoreGraphicsState()
        self.unlockFocus()
    }
}
