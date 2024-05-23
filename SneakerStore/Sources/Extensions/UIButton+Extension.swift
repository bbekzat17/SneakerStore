//
//  UIButton+Extension.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 11.04.2024.
//

import UIKit

extension UIButton {
    func setText(text: String, color: UIColor, size: CGFloat, weight: UIFont.Weight) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: size, weight: weight),
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        
        setAttributedTitle(attributedString, for: .normal)
    }
}

