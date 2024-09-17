//
//  CustomButton.swift
//  Navigation
//
//  Created by user on 17.09.2024.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    init(title: String, titleColor: UIColor, action: Selector, target: UIViewController?) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(target, action: action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
