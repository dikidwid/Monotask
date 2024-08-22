//
//  RewardListRepository.swift
//  Monotask
//
//  Created by Diki Dwi Diro on 21/08/24.
//

import Foundation

protocol RewardListRepository {
    func fetchRewards() -> [RewardModel]
    func updateReward(_ updatedReward: RewardModel)
}
