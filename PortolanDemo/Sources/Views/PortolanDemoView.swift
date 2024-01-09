//
//  PortolanDemoView.swift
//  Portolan
//
//  Created by Seunghun on 1/9/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import SwiftUI
import Portolan

struct PortolanDemoView: View {
    @State var pins: [PortolanPin] = []
    @State var metadata: [UUID: String] = [:]
    @State var result: String?
    
    var body: some View {
        ZStack {
            PortolanView(pins: $pins) { pin in
                result = metadata[pin.id] ?? ""
            } content: { pin in
                ZStack {
                    Circle()
                    Text(metadata[pin.id] ?? "")
                }
                .frame(width: 30, height: 30)
                .foregroundStyle(.blue)
            }
            .ignoresSafeArea()
            VStack {
                Spacer()
                if let result {
                    Text(result)
                }
                Button {
                    let pin = PortolanPin(latitude: Double.random(in: -90...90), longitude: Double.random(in: -180...180))
                    metadata[pin.id] = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑"].randomElement() ?? ""
                    pins.append(pin)
                } label: {
                    Text("Random Pin")
                }
            }
            .font(.system(size: 40, weight: .bold))
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    PortolanDemoView()
}
