//
//  SubtaskCell.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 23/08/24.
//

import UIKit

class SubtaskCell: UICollectionViewCell {
    
    private let subtaskLabel: UILabel = {
        let label = UILabel()
        label.font = .oswaldTitle3
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(subtaskLabel)
        
        // Subtask Label Constraints
        NSLayoutConstraint.activate([
            subtaskLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            subtaskLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with task: String) {
        subtaskLabel.text = "• \(task)"
    }
}
