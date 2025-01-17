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
    
    
    var body: some View {
        VStack {
            scrollableRewardShowcase
            
            Spacer()
            
            HStack(spacing: 20) {
                shareShowcaseButton
                
                backButton
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.fetchRewards()
            viewModel.setCurrentReward()
            viewModel.playShowcaseSoundEffect()
        }
        .onDisappear(perform: viewModel.stopShowcaseSoundEffect)
        .overlay {
            if viewModel.isShowPresentView,
               let currentReward = viewModel.currentReward {
                PresentView(rewardImage: currentReward.rewardPresentImage,
                            rewardName: currentReward.rewardName, 
                            rewardMessage: currentReward.rewardMessage, 
                            onDismiss: viewModel.onDismissPresentView)
            }
        }
        .animation(.easeInOut, value: viewModel.isShowPresentView)
    }
}

//#Preview {
//    let repository = RewardListRepositoryImpl()
//    let taskRepository = TaskListRepositoryImpl()
//    let useCase = RewardListUseCaseImpl(rewardRepository: repository, taskRepository: taskRepository)
//    let viewModel = RewardViewModel(useCaseReward: useCase)
//
//    return RewardView(viewModel: viewModel)
//}


extension RewardView {
    var scrollableRewardShowcase: some View {
        //scrollview
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(viewModel.rewards, id: \.self) { reward in
                    VStack {
                        let isComingSoon = reward.id == "Coming Soon"
                        Text(isComingSoon ? "Coming Soon" : "Stage \(reward.rewardNumber)")
                            .font(.oswaldLargeTitle)
                            .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                content
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                                    .brightness(phase.isIdentity ? 0 : 0.6)
                            }
                            .padding(.top)
                        
                        Text(isComingSoon ? "???" : "\(viewModel.displayRewardTotalTasks(reward))/\(reward.minimumTask) tasks")
                            .font(.oswaldTitle2)
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
                                        viewModel.unlockReward(reward)
                                    }
                                
                                Spacer()
                                
                            } else {
                                switch reward.rewardNumber{
                                case 1:
                                    ArtWaterView()
                                        .frame(width: 280)
                                        .onTapGesture {
                                            viewModel.isShowPresentView.toggle()
                                        }
                                case 2 :
                                    ArtHoldView()
                                        .frame(width: 280)
                                        .onTapGesture {
                                            viewModel.isShowPresentView.toggle()
                                        }
                                case 3:
                                    ArtStarView()
                                        .frame(width: 280)
                                        .onTapGesture {
                                            viewModel.isShowPresentView.toggle()
                                        }
                                default:
                                    ArtStarView()
                                        .frame(width: 280) // Default case
                                }
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
            item: Image(viewModel.currentReward?.rewardWallpaper ?? ""),
            preview: SharePreview("Share Wallpaper", image: Image(viewModel.currentReward?.rewardWallpaper ?? ""))
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
