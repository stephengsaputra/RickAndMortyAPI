//
//  UIViewExtensions.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 29/12/22.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        
        views.forEach { view in
            self.addSubview(view)
        }
    }
}
