//
//  HoldingButton.swift
//
//  Created by Itay Lador
//

import SwiftUI

let BUTTON_DIAMETER = UIScreen.main.bounds.width * 0.18

struct HoldingButton : View {
    let on_hold : () -> Void
    let on_press : () -> Void
    @State private var holding : Bool = false
    private let diameter : CGFloat
    
    init(on_hold: @escaping () -> Void, on_press: @escaping () -> Void,  diameter: CGFloat = CAPTURE_BUTTON_DIAMETER) {
        self.on_hold = on_hold
        self.on_press = on_press
        self.diameter = diameter
    }

    
    var body : some View {
        Button(action: {
            on_press()
            holding = false
        }) {
            
            ZStack {
                Circle()
                    .stroke(Color.white, lineWidth: 3)
                    .frame(width: diameter, height: diameter)
                
                Circle()
                    .fill(Color.white)
                    .frame(
                        width: holding ? diameter * 0.5 : diameter * 0.85,
                        height: holding ? diameter * 0.5 : diameter * 0.85
                    )
                    .animation(.smooth(duration: 0.3), value: holding)
            }
        }
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.1)
                .onEnded({ gesture in
                    if !holding {
                        holding = true
                    }
                    on_hold()
                })
        )
        .sensoryFeedback(.impact, trigger: holding)
    }
}
