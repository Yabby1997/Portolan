//
//  PortolanLocationSearchService.swift
//  Portolan
//
//  Created by Seunghun on 6/12/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import Foundation
import MapKit

/// A search service for `Portolan`.
public actor PortolanLocationSearchService {
    
    public init() {}
    
    /// Search locations for given query string.
    ///
    /// - Parameters:
    ///     - query: A ``String`` query to search location.
    /// - Returns: Array of search results.
    public func search(query: String) async -> [PortolanLocation] {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = query
        let search = MKLocalSearch(request: searchRequest)
        return await withCheckedContinuation { continuation in
            search.start { response, error in
                if let error {
                    print("Failed to search location with error: \(error.localizedDescription)")
                    continuation.resume(returning: [])
                    return
                }
                
                guard let response else {
                    continuation.resume(returning: [])
                    return
                }
                
                continuation.resume(
                    returning: response.mapItems
                        .compactMap { item in
                        guard let name = item.name,
                              let address = item.placemark.title else {
                            return nil
                        }
                        return PortolanLocation(
                            name: name,
                            address: address,
                            coordinate: PortolanCoordinate(
                                latitude: item.placemark.coordinate.latitude,
                                longitude: item.placemark.coordinate.longitude
                            )
                        )
                    }
                )
            }
        }
    }
}
