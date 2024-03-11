//
//  PortolanPin.swift
//  Portolan
//
//  Created by Seunghun on 1/9/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import Foundation

class PortolanPin: NSObject {
    public let id: UUID = UUID()
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
