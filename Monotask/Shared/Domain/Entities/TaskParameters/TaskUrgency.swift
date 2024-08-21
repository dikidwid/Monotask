//
//  TaskUrgency.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 20/08/24.
//

import Foundation

enum TaskUrgency: Identifiable, CaseIterable {
    case notUrgent
    case lessUrgent
    case urgent
    
    var id: String { return UUID().uuidString }

    var description: String {
        switch self {
        case .notUrgent:
            "Not Urgent"
        case .lessUrgent:
            "Less Urgent"
        case .urgent:
            "Urgent"
        }
    }
    
    var enabledImage: String {
        switch self {
        case .notUrgent:
            "not-urgent-enabled"
        case .lessUrgent:
            "less-urgent-enabled"
        case .urgent:
            "urgent-enabled"
        }
    }
    
    var disabledImage: String {
        switch self {
        case .notUrgent:
            "not-urgent-disabled"
        case .lessUrgent:
            "less-urgent-disabled"
        case .urgent:
            "urgent-disabled"
        }
    }
    
    var value: Int {
        switch self {
        case .notUrgent:
            1
        case .lessUrgent:
            2
        case .urgent:
            3
        }
    }
}
