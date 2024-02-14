//
//  PortolanCoordinate.swift
//  Portolan
//
//  Created by Seunghun on 2/14/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import CoreLocation

public struct PortolanCoordinate {
    public let latitude: Double
    public let longitude: Double
    public let timestamp: Date?
    
    init(latitude: Double, longitude: Double, timestamp: Date? = nil) {
        self.latitude = latitude
        self.longitude = longitude
        self.timestamp = timestamp
    }
}

extension CLLocation {
    var portolanCoordinate: PortolanCoordinate {
        .init(
            latitude: self.coordinate.latitude,
            longitude: self.coordinate.longitude,
            timestamp: self.timestamp
        )
    }
}
