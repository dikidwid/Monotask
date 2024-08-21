//
//  RewardLocalEntity.swift
//  Monotask
//
//  Created by Felicia Himawan on 19/08/24.
//

import Foundation
import SwiftData

@Model
class RewardLocalEntity{
    @Attribute(.unique)
    var id: String
    var rewardName: String
    var rewardDescription: String
    var minimumTask: Int
    var isUnlockedTap: Bool
    
    init(id: String, rewardName: String, rewardDescription: String, minimumTask: Int, isUnlockedTap: Bool) {
        self.id = id
        self.rewardName = rewardName
        self.rewardDescription = rewardDescription
        self.minimumTask = minimumTask
        self.isUnlockedTap = isUnlockedTap
    }
    
}

extension RewardLocalEntity{
    func toDomainReward() -> RewardModel{
        .init(
            id: self.id,
            rewardName: self.rewardName,
            rewardDescription: self.rewardDescription,
            minimumTask: self.minimumTask,
            isUnlockedTap: self.isUnlockedTap
        )
    }
}
