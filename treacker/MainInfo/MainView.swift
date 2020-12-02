//
//  ContentView.swift
//  treacker
//
//  Created by Константин Емельянов on 08.10.2020.
//  Copyright © 2020 Константин Емельянов. All rights reserved.
//

import SwiftUI
import MapKit


struct ContentView: View {
    
    @ObservedObject var stopWatch = StopWatch()
    @State var showMenu: Bool = false
    @State var showPenu: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                MainInfo(currentInfo: stopWatch.CurrentInfo)
                    .padding(.top)
               
                HStack {
                    PenuButton(show: $showPenu)
                        .offset(x: -30)
                    Spacer()
                    MapButton()
                    Spacer()
                    MenuButton(show: $showMenu)
                        .offset(x: 30)
                }
                .offset(y: -30)
                
                StartStopButton(stopWatch: stopWatch)
                    .offset(y: -30)

                
            }
            VStack {
                Spacer()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



// MARK: - MainInfo

struct MainInfo: View {
    
    let trackTime : String = "Общее время"
    let accurency : String = "Точность"
    let meticAccur: String = "м"
    let distanceText: String = "Расстояние"
    let metricDist: String = "км"
    let currSpeedText : String = "Скорость"
    let metricSpeed : String = "км/ч"
    let midSpeedText : String = "Средняя скорость"
    
    var currentInfo: MainModel
    
    var body: some View {
        VStack {
            HStack {
                Text(trackTime)
                Spacer()
                Text("\(accurency) \(currentInfo.accuren) \(meticAccur)")
                
            }
            HStack {
                Text(currentInfo.time)
                Spacer()
            }
            .font(.LargeTextFont)
            HStack {
                Text(distanceText)
                Spacer()
            }
            HStack() {
                Text(currentInfo.distance)
                Text(metricDist)
                Spacer()
            }
            .font(.LargeTextFont)
            HStack {
                Text(currSpeedText)
                Spacer()
            }
            HStack() {
                Text(currentInfo.currentSpeed)
                Text(metricSpeed)
                Spacer()
            }
            .font(.LargeTextFont)
            HStack {
                Text(midSpeedText)
                Spacer()
            }
            HStack() {
                Text(currentInfo.midSpeed)
                Text(metricSpeed)
                Spacer()
            }
            .font(.LargeTextFont)
        }   
        .padding(.horizontal)
        //        .background(Color.backLeplasak)
        .foregroundColor(.textLeplasak)
        
        Spacer()
    }
}

// MARK: - MenuButton

struct MenuButton: View {
    @Binding var show: Bool
    var body: some View {
        Button(action: {show.toggle()}) {
            HStack {
                Image(systemName: "list.bullet")
                    .foregroundColor(.textLeplasak)
                
                Spacer()
            }
            .padding(.leading, 18)
            .frame(width: 90, height: 60)
            .background(Color.backLeplasak)
            .cornerRadius(30)
            .shadow(color: .shadowLeplasak, radius: 10)
        }
    }   
}

// MARK: - MenuButton

struct PenuButton: View {
    @Binding var show: Bool
    var body: some View {
        Button(action: {show.toggle()}) {
            HStack {
                Spacer()
                Image(systemName: "list.bullet")
                    .foregroundColor(.textLeplasak)
            }
            .padding(.trailing, 18)
            .frame(width: 90, height: 60)
            .background(Color.backLeplasak)
            .cornerRadius(30)
            .shadow(color: .shadowLeplasak, radius: 10)
        }
    }   
}

// MARK: - MapButton

struct MapButton: View {
    @State var showMap: Bool = false
    let mapText = "Карта"
    var body: some View {
        Button(action: {showMap.toggle()}) {
            HStack {
                Image(systemName: "map")
                Text(mapText)
            }
            .foregroundColor(.textLeplasak)
            .padding(.trailing, 18)
            .frame(width: 200, height: 60)
            .background(Color.backLeplasak)
            .cornerRadius(30)
            .shadow(color: .shadowLeplasak, radius: 10)
        }   
        .fullScreenCover(isPresented: self.$showMap) {
            FinalMapView()
        }
    }
}   


// MARK: - StartStopButton

struct StartStopButton: View {
    
    let startText = "Старт"
    let stopText = "Стоп"
    let playImage = "play.circle.fill"
    let stopImage = "stop.circle.fill"
    
    @ObservedObject var stopWatch: StopWatch
    
    private func toggle() {
        if stopWatch.isPaused() {
            stopWatch.start()
        } else {
            stopWatch.pause()
            stopWatch.reset()
        }
    }
    
    var body: some View {
        Button(action: {self.toggle()}) {
            ZStack {
                Rectangle()
                    .foregroundColor(.backLeplasak)
                    .cornerRadius(50)
                    .padding()
                    .shadow(color: .shadowLeplasak, radius: 10, x: 0.0, y: 0.0)
                    .frame(width: 350, height: 100, alignment: .center)
                
                HStack {
                    Image(systemName: stopWatch.isPaused() ? playImage : stopImage)
                    Text(stopWatch.isPaused() ? startText : stopText)
                        .font(.largeTitle)
                        .fontWeight(.light)
                }
                .foregroundColor(stopWatch.isPaused() ? .blue : .red)
            }
        }
    }
}
