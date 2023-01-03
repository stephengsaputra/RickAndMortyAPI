//
//  UIViewExtensions.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 29/12/22.
//

import Foundation
import UIKit

extension UIView {
    
    /// Adds all UI elements to a UIView
    /// - Parameter views: UI elements to be added
    func addSubviews(_ views: UIView...) {
        
        views.forEach { view in
            self.addSubview(view)
        }
    }
}
