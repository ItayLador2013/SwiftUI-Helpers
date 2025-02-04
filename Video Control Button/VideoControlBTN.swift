//
//  CameraControlBTN.swift
//
//  Created by Itay Lador on 12/20/24.
//

import SwiftUI
import Foundation

let CAPTURE_BUTTON_DIAMETER: CGFloat = UIScreen.main.bounds.width * 0.18 // Adjust size as needed

struct VideoControlBTN<Label> : View where Label : View {
    let action : @MainActor () -> Void
    @ViewBuilder let view : () -> Label
    let on : Bool
    let orientaion : UIDeviceOrientation
    
    init(action: @escaping @MainActor () -> Void, @ViewBuilder label: @escaping () -> Label, orientaion : UIDeviceOrientation, on : Bool){
        self.action = action
        self.view = label
        self.orientaion = orientaion
        self.on = on
    }
    
    var body : some View {
        Button(action: {
            release_haptic_feedback()
            action()
        }) {
            view()
                .opacity(on ? 1.0 : 0.3)
                .rotationEffect(orientaion.isLandscape ? Angle.degrees(90) : Angle.degrees(0))
        }
        .padding([.top, .bottom], 5)
        .frame(width: CAPTURE_BUTTON_DIAMETER * 0.85)
        .foregroundStyle(on ? Color.cameraButton2 : Color.white)
        .bold()
        .background(on ? Material.thick : Material.ultraThin)
        .cornerRadius(10)
        .animation(.smooth, value: on)
    }
}
