//
//  PortolanLocationManager.swift
//  Portolan
//
//  Created by Seunghun on 1/12/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import Combine
import CoreLocation

public final class PortolanLocationManager: NSObject {
    /// Errors that can occur while using ``PortolanLocationManager``.
    public enum Errors: Error {
        case notDetermined
        case notAuthorized
    }
    
    private let locationManager = CLLocationManager()
    
    @Published var currentLocation: PortolanCoordinate? = nil
    public var currentLocationPublisher: AnyPublisher<PortolanCoordinate?, Never> {
        $currentLocation.compactMap { $0 }.eraseToAnyPublisher()
    }
    
    public override init() { 
        super.init()
        locationManager.delegate = self
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

extension PortolanLocationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let recentLocation = locations.last else { return }
        currentLocation = recentLocation.portolanCoordinate
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .denied:
            locationManager.requestWhenInUseAuthorization()
        default:
            locationManager.startUpdatingLocation()
        }
    }
}
