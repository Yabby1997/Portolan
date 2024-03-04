//
//  PortolanLocationManager.swift
//  Portolan
//
//  Created by Seunghun on 1/12/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import Combine
import CoreLocation

/// A location manager for `Portolan`.
public final class PortolanLocationManager {
    /// Errors that can occur while using ``PortolanLocationManager``.
    public enum Errors: Error {
        /// Indicates that camera access is not authorized.
        case notAuthorized
    }
    
    private let locationManager = CLLocationManager()
    private let coordinator = PortolanLocationManagerCoordinator()
    
    /// A ``PortolanCoordinate`` publisher that publishes latest coordinate.
    public var currentLocationPublisher: AnyPublisher<PortolanCoordinate?, Never> {
        coordinator.currentLocationPublisher.map { $0.portolanCoordinate }.eraseToAnyPublisher()
    }
    
    /// Creates a ``PortolanLocationManager`` instance.
    public init() {
        locationManager.delegate = coordinator
    }
    
    /// Sets up the ``PortolanLocationManager``.
    ///
    /// Call this method prior to using the location service. If this method fails, any of its functionality will not work properly.
    ///
    /// - Throws: Errors that occurred while configuring location manager, including authorization error.
    ///
    /// - Important: If it throws an authorization error, ``Errors/notAuthorized``, you must guide your user to manually grant authorization to use the location service and then call this method to try again.
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
