//
//  RewardModel.swift
//  MC3
//
//  Created by Diki Dwi Diro on 13/08/24.
//

import Foundation

struct RewardModel: Identifiable, Hashable {
    let id: String
    let rewardNumber: Int
    let rewardName: String
    let rewardDescription: String
    let rewardMessage: String
    let rewardWallpaper: String
    let rewardPresentImage: String
    let minimumTask: Int
    var isUnlockedTap: Bool
}
