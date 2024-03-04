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
    @StateObject var viewModel: PortolanDemoViewModel
    
    var body: some View {
        ZStack {
            PortolanView(
                pins: $viewModel.pins,
                currentLocation: $viewModel.currentLocation
            ) { pin in
                viewModel.result = viewModel.metadata[pin.id] ?? ""
            } content: { pin in
                ZStack {
                    Circle()
                    Text(viewModel.metadata[pin.id] ?? "")
                }
                .frame(width: 30, height: 30)
                .foregroundStyle(.blue)
            }
            .ignoresSafeArea()
            VStack {
                Spacer()
                if let result = viewModel.result {
                    Text(result)
                }
                Button {
                    let pin = PortolanPin(latitude: Double.random(in: -90...90), longitude: Double.random(in: -180...180))
                    viewModel.metadata[pin.id] = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑"].randomElement() ?? ""
                    viewModel.pins.append(pin)
                } label: {
                    Text("Random Pin")
                }
            }
            .font(.system(size: 40, weight: .bold))
            .foregroundStyle(.black)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    PortolanDemoView(viewModel: PortolanDemoViewModel())
}
