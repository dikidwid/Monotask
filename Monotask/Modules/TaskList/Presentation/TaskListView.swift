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
    
    @State private var checkTaskFrame: CGRect = .zero
    
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
                
                if taskListViewModel.showInstructionsOverlay {
                    instructionsOverlay
                }
                
                
            }
            .onAppear { taskListViewModel.getTasks() ; taskListViewModel.currentTask = taskListViewModel.tasks.first }
            .uncheckTaskAlert(isShowAlert: $taskListViewModel.isShowRemoveCheckmarkAlert) {
                taskListViewModel.updateTaskStatus($0)
                taskListViewModel.audioManager.playSoundEffectTwo(.unchecked, volume: 0.1)
            }
        }.coordinateSpace(name: "CheckTaskSpace")
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
    
    private var instructionsOverlay: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            
            Circle()
                .frame(width: 281, height: 281)
                .blendMode(.destinationOut)
                .offset(x: 0, y: -5)
            
            Text(taskListViewModel.instructionText)
                .foregroundColor(.black)
                .font(.oswaldTitle2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.vertical, 26)
                //.frame(width: 206, height: 78)
                .padding(.top, -16)
                .background(TutorialBubble()
                    .fill(Color.white)
                    //.padding(2)
                )
                .fixedSize(horizontal: true, vertical: false)
                .offset(x: 0, y: -190)
        }
        .compositingGroup()
        .allowsHitTesting(false)
        
    }


    
    
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
                    
                    Text("Tip : Think Small,\nTry 1 Step, 1 Task, 1 Thought…")
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
                                appCoordinator.present(.detailTask(task: task, onDismiss: { taskListViewModel.setCurrentTask(to: $0) }))
                                
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
            if taskListViewModel.totalTasks > 1 {
                LinearGradient(colors: taskListViewModel.whiteOverlay,
                               startPoint: .leading,
                               endPoint: .trailing)
                .allowsHitTesting(false)
            }
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
            appCoordinator.fullScreenCover(.addTaskDetail(onDismiss: { taskListViewModel.setCurrentTask(to: $0) }))
        } label: {
            HStack {
                Image(systemName: "plus")
                    .bold()
                
                Text("Add Task")
            }
        }
        .buttonStyle(CallToActionButtonStyle())
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


struct TutorialBubble: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.38356*height))
        path.addCurve(to: CGPoint(x: 0.13592*width, y: 0), control1: CGPoint(x: 0, y: 0.17173*height), control2: CGPoint(x: 0.06085*width, y: 0))
        path.addLine(to: CGPoint(x: 0.86408*width, y: 0))
        path.addCurve(to: CGPoint(x: width, y: 0.38356*height), control1: CGPoint(x: 0.93915*width, y: 0), control2: CGPoint(x: width, y: 0.17173*height))
        path.addCurve(to: CGPoint(x: 0.86408*width, y: 0.76712*height), control1: CGPoint(x: width, y: 0.5954*height), control2: CGPoint(x: 0.93915*width, y: 0.76712*height))
        path.addLine(to: CGPoint(x: 0.13592*width, y: 0.76712*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.38356*height), control1: CGPoint(x: 0.06085*width, y: 0.76712*height), control2: CGPoint(x: 0, y: 0.5954*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.52102*width, y: 0.96575*height))
        path.addCurve(to: CGPoint(x: 0.47898*width, y: 0.96575*height), control1: CGPoint(x: 0.51168*width, y: 1.01142*height), control2: CGPoint(x: 0.48832*width, y: 1.01142*height))
        path.addLine(to: CGPoint(x: 0.44114*width, y: 0.78082*height))
        path.addCurve(to: CGPoint(x: 0.46216*width, y: 0.67808*height), control1: CGPoint(x: 0.4318*width, y: 0.73516*height), control2: CGPoint(x: 0.44348*width, y: 0.67808*height))
        path.addLine(to: CGPoint(x: 0.53783*width, y: 0.67808*height))
        path.addCurve(to: CGPoint(x: 0.55885*width, y: 0.78082*height), control1: CGPoint(x: 0.55652*width, y: 0.67808*height), control2: CGPoint(x: 0.5682*width, y: 0.73516*height))
        path.addLine(to: CGPoint(x: 0.52102*width, y: 0.96575*height))
        path.closeSubpath()
        return path
    }
    
    
    
}
