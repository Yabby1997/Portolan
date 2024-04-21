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
    @Published var location: String = ""
    @Published var currentCoordinate: PortolanCoordinate? = nil
    
    private let locationManager = PortolanLocationManager()
    
    init() {
        locationManager.currentLocationPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$currentCoordinate)
    }
    
    func onAppear() {
        do {
            try locationManager.setup()
        } catch {
            print(error)
        }
    }
    
    func didTapFigureOutButton() {
        guard let currentCoordinate else { return }
        Task.detached {
            guard let location = await PortolanGeocoder.shared.represent(for: currentCoordinate) else { return }
            Task { @MainActor [weak self] in
                self?.location = location
            }
        }
    }
}
