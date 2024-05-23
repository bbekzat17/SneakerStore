//
//  CustomTextfield.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 02.04.2024.
//

import UIKit
import SnapKit

class CustomTextfield: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let customLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = customLeftView
        self.leftViewMode = .always
        self.textColor = .black
        self.font = UIFont.systemFont(ofSize: 16)
        self.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        self.tintColor = .black
    }
}

