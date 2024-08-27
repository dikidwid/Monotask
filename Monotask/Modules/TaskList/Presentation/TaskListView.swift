//
//  TaskListView.swift
//  MC3
//
//  Created by Diki Dwi Diro on 14/08/24.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var taskListViewModel: TaskListViewModel
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    var body: some View {
        NavigationStack {
            ZStack {
                if taskListViewModel.tasks.isEmpty {
                    createNewTaskText
                } else {
                    horizontalListTasksName
                }
                
                VStack {
                    todayTextView
                    
                    Spacer()
                    
                    checkTaskView
                        .overlay {
                            if taskListViewModel.tasks.isEmpty {
                                emptyStateImage
                            }
                        }
                    
                    Spacer()
                    
                    addTaskButton
                }
                .overlay(alignment: .topTrailing) {
                    showcaseJourneyButton
                }
                .padding(.top, 20)
            }
            .onAppear(perform: taskListViewModel.onAppearAction)
            .uncheckTaskAlert(isShowAlert: $taskListViewModel.isShowRemoveCheckmarkAlert) {
                taskListViewModel.updateTaskStatus($0)
                taskListViewModel.audioManager.playSoundEffectTwo(.unchecked, volume: 0.1)
            }
        }
    }
}

#Preview {
    let taskListRepository = TaskListRepositoryImpl()
    let rewardListRepository = RewardListRepositoryImpl()
    let useCase = TaskListUseCaseImpl(repository: taskListRepository, rewardListRepository: rewardListRepository)
    let viewModel = TaskListViewModel(useCase: useCase)
    
    return TaskListView(taskListViewModel: viewModel)
}

// MARK: - Private
// Extension for create each component in the view
extension TaskListView {
    private var createNewTaskText: some View {
        Text("Create a New Task")
            .font(.oswaldLargeEmphasized)
            .foregroundStyle(.black)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 100)
    }
    
    private var emptyStateImage: some View {
        Rectangle()
            .fill(.white)
            .overlay {
                VStack {
                    Image(.emptyState)
                    
                    Text("Tip : Think Small \n, Try 1 Step, 1 Task, 1 Thought…")
                        .font(.oswaldBody)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                }
            }
    }
    
    private var horizontalListTasksName: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(taskListViewModel.tasks, id: \.self) { task in
                    Rectangle()
                        .fill(.clear)
                        .overlay(alignment: .top) {
                                Button {
                                    appCoordinator.present(.detailTask(task: task, onDismiss: {taskListViewModel.getTasks()}))
                                    
                                } label: {
                                    Text(task.taskName)
                                        .font(.oswaldLargeTitle)
                                        .underline(taskListViewModel.currentTask == task)
                                        .multilineTextAlignment(.center)
                                        .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                            content
                                                .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                                                .brightness(phase.isIdentity ? 0 : 0.6)
                                        }
                                }
                                
                                
                        }
                        .frame(width: 250)
                        .padding(.top, 100)
                        .tint(.black)
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
        .safeAreaPadding(.horizontal, 70)
        .scrollPosition(id: $taskListViewModel.currentTask, anchor: .center)
        .overlay {
            LinearGradient(colors: taskListViewModel.whiteOverlay,
                           startPoint: .leading,
                           endPoint: .trailing)
            .allowsHitTesting(false)
        }
    }
    
    private var todayTextView: some View {
        VStack {
            Text("Today")
                .foregroundStyle(Color(hex: "707070"))
                .font(.oswald(.regular, size: 24))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 2.5)
            
            Text("Tasks Done (\(taskListViewModel.totalCompletedTasks)/\(taskListViewModel.totalTasks))")
                .foregroundStyle(Color(hex: "707070"))
                .font(.oswald(.regular, size: 24))
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    private var addTaskButton: some View {
        Button {
            appCoordinator.fullScreenCover(.addTaskDetail(onDismiss: { taskListViewModel.setAddedTask($0) }))
        } label: {
            HStack {
                Image(systemName: "plus")
                    .bold()
                
                Text("Add Task")
            }
        }
        .buttonStyle(CallToActionButtonStyle())
        .padding(.bottom)
    }
    
    private var checkTaskView: some View {
        CheckTaskView(task: taskListViewModel.currentTask) { taskListViewModel.updateTaskStatus($0) }
            .overlay {
                if let task = taskListViewModel.currentTask,
                   task.isCompleted {
                    Rectangle()
                        .fill(.clear)
                        .contentShape(Circle())
                        .onTapGesture {
                            taskListViewModel.isShowRemoveCheckmarkAlert = true
                        }
                }
            }
    }
    
    private var showcaseJourneyButton: some View {
        Button {
            appCoordinator.push(.showcaseJourney)
        } label: {
            Circle()
                .foregroundStyle(.black)
                .frame(width: 36, height: 36)
                .overlay {
                    Image(.showcaseIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 9)
                }
                .overlay(alignment: .topTrailing) {
                    if taskListViewModel.hasNewReward {
                        Circle()
                            .fill(Color.appAccentColor)
                            .frame(width: 13, height: 13)
                            .offset(x: 3, y: -3)
                    }
                }
                .padding(.trailing, 26)
        }
    }
}

extension View {
    fileprivate func uncheckTaskAlert(isShowAlert: Binding<Bool>, onDismiss: @escaping ((Bool) -> Void?)) -> some View {
        modifier(TaskListAlertModifier(isShowAlert: isShowAlert, onDismiss: onDismiss))
    }
}

struct TaskListAlertModifier: ViewModifier {
    var isShowAlert: Binding<Bool>
    let onDismiss: ((Bool) -> Void?)
    
    func body(content: Content) -> some View {
        content
            .alert("Uncheck Task",
                   isPresented: isShowAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Uncheck", role: .destructive) { onDismiss(false)}
            } message: {
                Text("Do you want to uncheck this task?")
            }
    }
}
