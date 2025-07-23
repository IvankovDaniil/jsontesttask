//
//  UIView.swift
//  JSONTestTask
//
//  Created by Даниил Иваньков on 22.07.2025.
//

import UIKit

extension UIView {
    
    func addSubViews(_ views: UIView ...) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
}
