//
//  LoadingAnimation.swift
//
//  Created by Itay Lador
//

import SwiftUI

struct LoadingAnimation : View {
    @State private var degree:Int = 270
    @State private var spinnerLength = 0.6
    
    func animate() {
        withAnimation(Animation.smooth(duration: 1.5).repeatForever(autoreverses: true)) {
            degree = 270 + 360
        }
        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: true)) {
            spinnerLength = 0
        }
    }
    
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0.0,to: spinnerLength)
                .stroke(LinearGradient(colors: [.selectedOrange, .selectedYellow,.blue], startPoint: .topLeading, endPoint: .bottomTrailing),style: StrokeStyle(lineWidth: 8.0,lineCap: .round,lineJoin:.round))
                .frame(width: 60,height: 60)
                .rotationEffect(Angle(degrees: Double(degree)))
                .onAppear{
                    animate()
                }
        }
    }
}
