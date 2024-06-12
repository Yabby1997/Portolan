//
//  PortolanLocation.swift
//  Portolan
//
//  Created by Seunghun on 6/12/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import Foundation

/// A struct represents specific location.
public struct PortolanLocation: Sendable{
    /// Name of location.
    public let name: String
    /// Address of location.
    public let address: String
    /// Coordinate of location.
    public let coordinate: PortolanCoordinate
}
