//
//  PortolanView.swift
//  Portolan
//
//  Created by Seunghun on 1/9/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import SwiftUI

public struct PortolanView<Content>: View where Content: View {
    @Binding var pins: [PortolanPin]
    @Binding var currentLocation: PortolanCoordinate?
    let selection: (PortolanPin) -> Void
    @ViewBuilder var content: (PortolanPin) -> Content
    
    public var body: some View {
        MapViewRepresentable(
            pins: $pins,
            currentLocation: $currentLocation,
            selection: selection,
            content: content
        )
    }
    
    public init(
        pins: Binding<[PortolanPin]>,
        currentLocation: Binding<PortolanCoordinate?>,
        selection: @escaping (PortolanPin) -> Void,
        @ViewBuilder content: @escaping (PortolanPin) -> Content
    ) {
        self._pins = pins
        self._currentLocation = currentLocation
        self.selection = selection
        self.content = content
    }
}

#Preview {
    PortolanView(
        pins: .constant([.init(latitude: 42, longitude: 72)]),
        currentLocation: .constant(.init(latitude: 36.63674927, longitude: 127.51011936))
    ) { pin in
        print(pin.id)
    } content: { pin in
        Circle()
            .foregroundStyle(.red)
    }
}
