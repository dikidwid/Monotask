//
//  CircularButton.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 23/08/24.
//

import UIKit

class CircularButton: UIButton {
    private let iconName: String
    
    init(iconName: String, frame: CGRect = .zero) {
        self.iconName = iconName
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .black
        tintColor = .white
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold, scale: .default)
        let iconImage = UIImage(systemName: iconName, withConfiguration: configuration)
        setImage(iconImage, for: .normal)
    
        // Make the button circular
        layer.cornerRadius = 22
        clipsToBounds = true
    }
}
