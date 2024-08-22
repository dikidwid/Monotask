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
    var rewardNumber: Int
    var rewardName: String
    var rewardDescription: String
    var rewardMessage: String
    var rewardWallpaper: String
    var rewardPresentImage: String
    var minimumTask: Int
    var isUnlockedTap: Bool
    
    init(
        id: String,
        rewardNumber: Int,
        rewardName: String,
        rewardDescription: String,
        rewardMessage: String,
        rewardWallpaper: String,
        rewardPresentImage: String,
        minimumTask: Int,
        isUnlockedTap: Bool
    ) {
        self.id = id
        self.rewardNumber = rewardNumber
        self.rewardName = rewardName
        self.rewardDescription = rewardDescription
        self.rewardMessage = rewardMessage
        self.rewardWallpaper = rewardWallpaper
        self.rewardPresentImage = rewardPresentImage
        self.minimumTask = minimumTask
        self.isUnlockedTap = isUnlockedTap
    }
}

extension RewardLocalEntity{
    func toDomainReward() -> RewardModel{
        .init(
            id: self.id,
            rewardNumber: self.rewardNumber,
            rewardName: self.rewardName,
            rewardDescription: self.rewardDescription,
            rewardMessage: self.rewardMessage,
            rewardWallpaper: self.rewardWallpaper,
            rewardPresentImage: self.rewardPresentImage,
            minimumTask: self.minimumTask,
            isUnlockedTap: self.isUnlockedTap
        )
    }
}
