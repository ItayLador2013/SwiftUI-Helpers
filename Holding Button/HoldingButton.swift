//
//  HoldingButton.swift
//
//  Created by Itay Lador
//

import SwiftUI

struct HoldingButton<Label> : View where Label : View {
    let on_hold : () -> Void
    let on_press : () -> Void
    @State private var holding : Bool = false
    let label : (Bool) -> Label
    
    init(on_hold: @escaping () -> Void, on_press: @escaping () -> Void, label : @escaping (Bool) -> Label) {
        self.on_hold = on_hold
        self.on_press = on_press
        self.label = label
    }

    
    var body : some View {
        Button(action: {
            on_press()
            holding = false
        }) {
            label(holding)
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
