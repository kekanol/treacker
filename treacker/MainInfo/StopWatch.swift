//
//  StopWatch.swift
//  treacker
//
//  Created by Константин Емельянов on 12.10.2020.
//  Copyright © 2020 Константин Емельянов. All rights reserved.
//

import Combine
import Foundation
import SwiftUI
import MapKit

final class StopWatch: ObservableObject {
    
    @Published var CurrentInfo = MainModel()
    
    //MARK: - Geo Params
    
    private let locationManager = CLLocationManager()
    private var totalDist: Float = 0
    private var currLocation =  CLLocationManager().location ?? CLLocation.init(latitude: 0, longitude: 0)
    
    private func getParameters() {
        CurrentInfo.currentSpeed = getSpeed()
        CurrentInfo.distance = getDistance()
        CurrentInfo.accuren = getAccurancy()
        CurrentInfo.midSpeed = getMidSpeed()
        CurrentInfo.time = self.stopWatchTime
        self.currLocation = locationManager.location ?? CLLocation.init(latitude: 0, longitude: 0)
    }
    
    private func getSpeed() -> String {
        var speed = ((locationManager.location?.speed  ?? 0 ) * 3.6 ).rounded()
        if speed < 0 {
            speed = 0
        }
        if speed == 0 {
            return "0"
        } else {
            return "\(speed)"
        }
    }
    
    private func getDistance() -> String {
        let distance = Float((locationManager.location?.distance(from: currLocation) ?? 0) / 1000)
        totalDist += distance
        if totalDist == 0 {
            return "0"
        } else {
            return String("\(totalDist)".prefix(5))
        }
    }
    
    private func getMidSpeed() -> String {
         
        let midSpeed = (totalDist / Float(counter)) * 3600
        if midSpeed == 0 {
            return "0"
        } else {
            return String("\(midSpeed)".prefix(3))
        }
    }
    
    private func getAccurancy() -> String {
        String(Int(min(locationManager.location?.verticalAccuracy ?? 0, locationManager.location?.horizontalAccuracy ?? 0)))
    }
    
    
    // MARK: - Timer
    
    private var sourceTimer: DispatchSourceTimer?
    private let queue = DispatchQueue(label: "stopwatch.timer")
    private var counter: Int = 0
    
    var stopWatchTime = "00:00" {
        didSet {
            self.update()
        }
    }
    
    var paused = true {
        didSet {
            self.update()
        }
    }
    
    func start() {
        self.paused = !self.paused
        
        guard let _ = self.sourceTimer else {
            self.startTimer()
            return
        }
        self.resumeTimer()
        
    }
    
    func pause() {
        self.paused = !self.paused
        self.sourceTimer?.suspend()
    }
    
    
    func reset() {
        self.stopWatchTime = "00:00"
        self.counter = 0
        self.CurrentInfo.accuren = "0"
        self.CurrentInfo.currentSpeed = "0"
        self.CurrentInfo.distance = "0"
        self.CurrentInfo.midSpeed = "0"
        self.totalDist = 0
    }
    
    func update() {
        getParameters()
        objectWillChange.send()
    }
    
    func isPaused() -> Bool {
        return self.paused
    }
    
    private func startTimer() {
        self.sourceTimer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags.strict,
                                                          queue: self.queue)
        self.resumeTimer()
        self.currLocation = self.locationManager.location ?? CLLocation.init(latitude: 0, longitude: 0)
    }
    
    private func resumeTimer() {
        self.sourceTimer?.setEventHandler {
            self.updateTimer()
        }
        
        self.sourceTimer?.schedule(deadline: .now(),
                                   repeating: 1.0)
        self.sourceTimer?.resume()
    }
    
    private func updateTimer() {
        self.counter += 1
        DispatchQueue.main.sync {
            self.stopWatchTime = StopWatch.convertCountToTimeString(counter: self.counter)
        }
    }
}



extension StopWatch {
    static func convertCountToTimeString(counter: Int) -> String {
        var seconds = counter 
        let minutes = counter / 60
        
        
        if counter > 59 {
            seconds = counter - minutes * 60
        }
        
        var secondsString = "\(seconds)"
        var minutesString = "\(minutes)"
        
        
        
        if seconds < 10 {
            secondsString = "0" + secondsString
        }
        
        if minutes < 10 {
            minutesString = "0" + minutesString
        }
        
        return "\(minutesString):\(secondsString)"
    }
}


