//
//  FinalMapView.swift
//  treacker
//
//  Created by Константин Емельянов on 14.10.2020.
//  Copyright © 2020 Константин Емельянов. All rights reserved.
//

import Foundation
import SwiftUI


struct FinalMapView: View {
    @Environment(\.presentationMode) var present
    
    var body: some View {
        ZStack {
            MapView()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    BackButton(present: present)
                    Spacer()
                    GeoButton()
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
    }
}


struct BackButton: View {
    @Binding var present: PresentationMode
    var body: some View {
        HStack {
            Image(systemName: "chevron.down.circle.fill")
                .resizable()
                .scaledToFill()
        }
        .foregroundColor(.mapButton)
        .frame(width: 40, height: 40)
        .cornerRadius(20)
        .shadow(color: .shadowLeplasak, radius: 10)
        .onTapGesture {
            present.dismiss()
        }
    }
}

struct GeoButton: View {
    
    func drawToCurrent() {
        print(1)
    }
    
    var body: some View {
        HStack {
            Image(systemName: "location.circle.fill")
                .resizable()
                .scaledToFit()
        }
        .foregroundColor(.mapButton)
        .frame(width: 40, height: 40)
        .cornerRadius(20)
        .shadow(color: .shadowLeplasak, radius: 10)
        .onTapGesture {
            drawToCurrent()
        }
    }
}
