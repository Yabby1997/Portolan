//
//  PortolanCoordinate.swift
//  Portolan
//
//  Created by Seunghun on 2/14/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import CoreLocation

public struct PortolanCoordinate: Hashable {
    public let latitude: Double
    public let longitude: Double
    public let timestamp: Date?
    
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
