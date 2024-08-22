//
//  RewardModel.swift
//  MC3
//
//  Created by Diki Dwi Diro on 13/08/24.
//

import Foundation

#warning("TODO: Update this model to conform the view's needs")
struct RewardModel: Identifiable, Hashable {
    let id: String
    let rewardNumber: Int
    let rewardName: String
    let rewardDescription: String
    let rewardWallpaper: String
    let rewardPresentImage: String
    let minimumTask: Int
    var isUnlockedTap: Bool
}
