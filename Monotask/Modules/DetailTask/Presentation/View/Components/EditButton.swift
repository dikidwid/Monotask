//
//  EditButton.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 23/08/24.
//

import UIKit

class EditButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = .black
        tintColor = .white
        
        var config = UIButton.Configuration.plain()
        
        config.title = "Edit Task"
        config.image = UIImage(systemName: "pencil")
        
        config.attributedTitle = AttributedString("Edit Task",
                                                  attributes: AttributeContainer([.font: UIFont.oswaldTitle3]))
        
        config.imagePadding = 10
        config.imagePlacement = .leading
        
        self.configuration = config
        
        layer.cornerRadius = 30
    }
}