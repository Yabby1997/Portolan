//
//  PortolanGeocoder.swift
//  Portolan
//
//  Created by Seunghun on 3/4/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import CoreLocation

/// A geocoder for `Portolan`.
public class PortolanGeocoder {
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
        let locale = Locale.current
        return await withCheckedContinuation { continuation in
            geocoder.reverseGeocodeLocation(coordinate.clLocation, preferredLocale: locale) { placemark, error in
                if error != nil {
                    continuation.resume(returning: nil)
                    return
                }
                
                var title = ""
                
                guard let place = placemark?.first else {
                    continuation.resume(returning: title)
                    return
                }
                
                if let landmark = place.areasOfInterest?.first {
                    title = landmark
                } else if let locality = place.locality, let sublocality = place.subLocality {
                    title = locality + " - " + sublocality
                } else if let country = place.country, let locality = place.locality {
                    title = country + " - " + locality
                } else if let country = place.country {
                    title = country
                }
                continuation.resume(returning: title)
            }
        }
    }
}
