//
//  PortolanCoordinate.swift
//  Portolan
//
//  Created by Seunghun on 2/14/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import CoreLocation

/// A struct represents coordinate for `Portolan`.
public struct PortolanCoordinate: Hashable, Sendable {
    /// Latitude value of coordinate.
    public let latitude: Double
    /// Longitude value of coordinate.
    public let longitude: Double
    /// Timestamp indicating when this coordinate is generated.
    public let timestamp: Date?
    
    /// Creates a ``PortolanCoordinate`` instance.
    ///
    /// - Parameters:
    ///     - latitude: Latitude value of coordinate.
    ///     - longitude: Longitude value of coordinate.
    ///     - timestamp: Timestamp indicating when this coordinate is generated. Default value is `nil`.
    public init(latitude: Double, longitude: Double, timestamp: Date? = nil) {
        self.latitude = latitude
        self.longitude = longitude
        self.timestamp = timestamp
    }
}

extension CLLocation {
    var portolanCoordinate: PortolanCoordinate {
        .init(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude,
            timestamp: timestamp
        )
    }
}

extension PortolanCoordinate {
    var clLocation: CLLocation {
        .init(latitude: latitude, longitude: longitude)
    }
}
