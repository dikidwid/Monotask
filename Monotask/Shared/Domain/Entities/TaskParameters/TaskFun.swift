//
//  TaskFun.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 20/08/24.
//

import Foundation

enum TaskFun: Identifiable, CaseIterable {
    case notFun
    case neutral
    case fun
    
    var id: String { return UUID().uuidString }

    var description: String {
        switch self {
        case .notFun:
            "Not Fun"
        case .neutral:
            "Neutral"
        case .fun:
            "Fun"
        }
    }
    
    var enabledImage: String {
        switch self {
        case .notFun:
            "not-fun-enabled"
        case .neutral:
            "neutral-enabled"
        case .fun:
            "fun-enabled"
        }
    }
    
    var disabledImage: String {
        switch self {
        case .notFun:
            "not-fun-disabled"
        case .neutral:
            "neutral-disabled"
        case .fun:
            "fun-disabled"
        }
    }
    
    var value: Int {
        switch self {
        case .notFun:
            1
        case .neutral:
            2
        case .fun:
            3
        }
    }
}
