//
//  PortolanDemoViewModel.swift
//  Portolan
//
//  Created by Seunghun on 1/12/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import Foundation
import Portolan

final class PortolanDemoViewModel: ObservableObject {
    @Published var pins: [PortolanPin] = []
    @Published var metadata: [UUID: String] = [:]
    @Published var result: String?
    
    @Published var currentLocation: PortolanCoordinate? = nil
    
    private let locationManager = PortolanLocationManager()
    
    init() {
        locationManager.currentLocationPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$currentLocation)
    }
    
    func onAppear() {
        do {
            try locationManager.setup()
        } catch {
            print(error)
        }
    }
}
