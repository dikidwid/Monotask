//
//  RewardView.swift
//  Monotask
//
//  Created by Felicia Himawan on 19/08/24.
//
import SwiftUI

struct RewardView: View {
    @StateObject var viewModel: RewardViewModel
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    @State private var showPresent = false
    
    var body: some View {
        VStack {
            scrollableRewardShowcase
            
            Spacer()
            
            HStack(spacing: 20) {
                shareShowcaseButton
                
                backButton
            }
            .padding(.bottom)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.fetchRewards()
            viewModel.resetUnlockedRewardsIfNeeded()
            viewModel.updateCurrentRewardState()
            viewModel.playShowcaseSoundEffect()
        }
        .onDisappear(perform: viewModel.stopShowcaseSoundEffect)
        .overlay {
            if showPresent {
                PresentView(showPresent: $showPresent)
            }
        }
    }
    
    func goalText(reward: RewardModel) -> some View {
        let displayedCompletedTasks: Int
        
        if viewModel.totalCompletedTasks >= reward.minimumTask {
            displayedCompletedTasks = reward.minimumTask
        } else {
            displayedCompletedTasks = viewModel.totalCompletedTasks
        }
        
        if reward.id == "1" {
            return Text("\(displayedCompletedTasks)/\(reward.minimumTask) tasks")
                .font(.oswaldTitle2)
        } else if reward.id == "2" {
            return Text("\(displayedCompletedTasks)/\(reward.minimumTask) tasks")
                .font(.oswaldTitle2)
        } else {
            return Text("\(displayedCompletedTasks)/\(reward.minimumTask) tasks")
                .font(.oswaldTitle2)
        }
    }
    
}

#Preview {
    let repository = RewardListRepositoryImpl()
    let taskRepository = TaskListRepositoryImpl()
    let useCase = RewardListUseCaseImpl(rewardRepository: repository, taskRepository: taskRepository)
    let viewModel = RewardViewModel(useCaseReward: useCase)
    
    return RewardView(viewModel: viewModel)
}


extension RewardView {
    var scrollableRewardShowcase: some View {
        //scrollview
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(viewModel.rewards, id: \.self) { reward in
                    VStack {
                        Text("Stage \(reward.id)")
                            .font(.oswaldLargeTitle)
                            .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                content
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                                    .brightness(phase.isIdentity ? 0 : 0.6)
                            }
                            .padding(.top)
                        
                        goalText(reward: reward)
                            .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0)
                            }
                        
                        Group {
                            
                            Spacer()
                            
                            if (viewModel.totalCompletedTasks < reward.minimumTask){
                                Image(.lock)
                                
                                Spacer()
                                
                            }
                            else if (!reward.isUnlockedTap){
                                UnlockedView()
                                    .onTapGesture {
                                        withAnimation {
                                            showPresent = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                                viewModel.unlockReward(reward)
                                            }
                                        }
                                    }
                                
                                Spacer()
                                
                            }
                            else{
                                ArtView()
                                    .frame(width: 280)
                            }
                        }
                        .scrollTransition(.animated, axis: .horizontal) { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1.0 : 0)
                        }
                        
                        VStack{
                            Text(reward.isUnlockedTap ? reward.rewardName : "???")
                                .font(.oswaldTitle1)
                                .padding(.bottom, 4)
                            
                            Text(reward.isUnlockedTap ? reward.rewardDescription : "")
                                .font(.oswaldCallout)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .padding(.bottom)
                                .frame(width: 250)
                        }
                        .scrollTransition(.animated, axis: .horizontal) { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0)
                        }
                    }
                    .frame(width: 200)
                }
                
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $viewModel.currentReward, anchor: .center)
        .safeAreaPadding(.horizontal, 97)
        .overlay {
            LinearGradient(colors: viewModel.whiteOverlay,
                           startPoint: .leading,
                           endPoint: .trailing)
            .allowsHitTesting(false)
        }
    }
    
    var shareShowcaseButton: some View {
        ShareLink(
            item: Image("Wallpaper"),
            preview: SharePreview("Share Wallpaper", image: Image("Wallpaper"))
        ) {
            HStack {
                Image(systemName: "square.and.arrow.down")
                    .bold()
                Text("Save")
            }
        }
        .buttonStyle(CallToActionButtonStyle(isDisable: !viewModel.isRewardLocked))
        .disabled(!(viewModel.currentReward?.isUnlockedTap ?? false))
    }
    
    var backButton: some View {
        Button{
            appCoordinator.pop()
        } label: {
            HStack{
                Image(systemName: "chevron.left")
                    .bold()
                Text("Back")
            }
        }
        .buttonStyle(BackButtonStyle())
    }
}
