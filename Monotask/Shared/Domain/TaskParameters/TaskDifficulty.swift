//
//  TaskDifficulty.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 20/08/24.
//

import Foundation

enum TaskDifficulty: Identifiable, CaseIterable {
    case easy
    case medium
    case hard
    
    var id: String { return UUID().uuidString }

    var description: String {
        switch self {
        case .easy:
            "Easy"
        case .medium:
            "Medium"
        case .hard:
            "Hard"
        }
    }
    
    var enabledImage: String {
        switch self {
        case .easy:
            "easy-enabled"
        case .medium:
            "medium-enabled"
        case .hard:
            "hard-enabled"
        }
    }
    
    var disabledImage: String {
        switch self {
        case .easy:
            "easy-disabled"
        case .medium:
            "medium-disabled"
        case .hard:
            "hard-disabled"
        }
    }
    
    var value: Int {
        switch self {
        case .easy:
            1
        case .medium:
            2
        case .hard:
            3
        }
    }
}
