//
//  PortolanLocationManager.swift
//  Portolan
//
//  Created by Seunghun on 1/12/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import Combine
import CoreLocation

public final class PortolanLocationManager {
    
    /// Errors that can occur while using ``PortolanLocationManager``.
    public enum Errors: Error {
        case notAuthorized
    }
    
    private let locationManager = CLLocationManager()
    private let coordinator = PortolanLocationManagerCoordinator()
    
    public var currentLocationPublisher: AnyPublisher<PortolanCoordinate?, Never> {
        coordinator.currentLocationPublisher.map { $0.portolanCoordinate }.eraseToAnyPublisher()
    }
    
    public init() {
        locationManager.delegate = coordinator
    }
    
    public func setup() throws {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            throw Errors.notAuthorized
        default:
            locationManager.startUpdatingLocation()
        }
    }
}

class PortolanLocationManagerCoordinator: NSObject, CLLocationManagerDelegate {
    @Published private var currentLocation: CLLocation? = nil
    var currentLocationPublisher: AnyPublisher<CLLocation, Never> { $currentLocation.compactMap{ $0 }.eraseToAnyPublisher() }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied:
            manager.requestWhenInUseAuthorization()
        default:
            manager.startUpdatingLocation()
        }
    }
}
