//
//  UIView+Extension.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/18/24.
//

import SwiftUI

extension UIView {
 
    var snapshot: UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let capturedImage = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        return capturedImage
    }
}
