//
//  PortolanPinView.swift
//  Portolan
//
//  Created by Seunghun on 1/9/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import MapKit

final class PortolanPinView: MKAnnotationView {
    var contentView: UIView? {
        didSet { setupContentView() }
    }

    override func prepareForReuse() {
        contentView?.removeFromSuperview()
    }

    private func setupContentView() {
        guard let contentView else { return }
        contentView.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
