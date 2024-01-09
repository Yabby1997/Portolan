//
//  MapViewRepresentable.swift
//  Portolan
//
//  Created by Seunghun on 1/9/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import SwiftUI
import MapKit

struct MapViewRepresentable<Content>: UIViewRepresentable where Content: View {
    @Binding var pins: [PortolanPin]
    let selection: (PortolanPin) -> Void
    @ViewBuilder var content: (PortolanPin) -> Content
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewRepresentable
        
        init(_ parent: MapViewRepresentable) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
            guard let pin = (parent.pins.first { $0 == (annotation as? PortolanPin) }) else { return }
            parent.selection(pin)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(PortolanPinView.self), for: annotation)
            guard let pin = annotation as? PortolanPin,
                  let pinView = pinView as? PortolanPinView else { return pinView }
            pinView.contentView = UIHostingController(rootView: parent.content(pin)).view
            return pinView
        }
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let mapView = uiView as? MKMapView else { return }
        mapView.addAnnotations(pins)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.register(PortolanPinView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(PortolanPinView.self))
        return mapView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension PortolanPin: MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
