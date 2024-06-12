//
//  PortolanGeocoder.swift
//  Portolan
//
//  Created by Seunghun on 3/4/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

@preconcurrency import CoreLocation

/// A geocoder for `Portolan`.
@globalActor
public actor PortolanGeocoder {
    /// A shared instance of ``PortolanGeocoder``.
    public static let shared = PortolanGeocoder()
    
    private let geocoder = CLGeocoder()
    private var cache: [PortolanCoordinate: String] = [:]
    
    private init() {}
    
    /// Generates a geocoded result for provided coordinate.
    ///
    /// - Parameters:
    ///     - coordinate: A ``PortolanCoordinate`` value to generate geocoding result.
    /// - Returns: Geocoded result for provided `coordinate`.
    public func represent(for coordinate: PortolanCoordinate) async -> String? {
        guard let representation = cache[coordinate] else {
            let representation = await generate(for: coordinate)
            cache[coordinate] = representation
            return representation?.isEmpty == true ? nil : representation
        }
        return representation.isEmpty ? nil : representation
    }
    
    private func generate(for coordinate: PortolanCoordinate) async -> String? {
        geocoder.cancelGeocode()
        guard let placemarks = try? await geocoder.reverseGeocodeLocation(coordinate.clLocation),
              let placemark = placemarks.first else {
            return nil
        }
        
        if let landmark = placemark.areasOfInterest?.first {
            return landmark
        } else if let locality = placemark.locality, let sublocality = placemark.subLocality {
            return locality + " - " + sublocality
        } else if let country = placemark.country, let locality = placemark.locality {
            return country + " - " + locality
        } else if let country = placemark.country {
            return country
        }
        return nil
    }
}
