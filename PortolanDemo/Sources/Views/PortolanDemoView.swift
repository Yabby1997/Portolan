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
        VStack {
            Spacer()
            VStack(spacing: 8) {
                HStack {
                    Text("latitude: \(viewModel.currentCoordinate?.latitude ?? .zero)")
                    Text("longitude: \(viewModel.currentCoordinate?.longitude ?? .zero)")
                }
                Text("\(viewModel.location)")
            }
            Spacer()
            Button(action: viewModel.didTapFigureOutButton) {
                Text("Figure out!")
            }
        }
    }
}

#Preview {
    PortolanDemoView(viewModel: PortolanDemoViewModel())
}
