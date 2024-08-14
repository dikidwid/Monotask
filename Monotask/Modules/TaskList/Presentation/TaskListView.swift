//
//  TaskListView.swift
//  MC3
//
//  Created by Diki Dwi Diro on 14/08/24.
//

import SwiftUI

struct TaskListView: View {
    
    @StateObject var taskListViewModel: TaskListViewModel
    
    @State var opacityFirstInnerTasks:Double = 0
    @State var opacitySecondInnerTasks:Double = 0
    @State var opacityThirdInnerTasks:Double = 0
    
    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                Text("Today")
                    .foregroundStyle(Color(hex: "707070"))
                    .font(.oswald(.regular, size: 24))
                    .padding(.top, 24)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .center)
                                
                Button {
                    
                } label: {
                    Circle()
                        .fill(.black)
                        .frame(width: 36, height: 36)
                        .overlay {
                            Image(.rewardIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.horizontal, 9)
                        }
                        .padding(.trailing, 26)
                        .padding(.top)

                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(maxWidth: .infinity)
            
            Text("Research on ADHD")
                .font(.oswaldLargeTitle)
                .underline()
                .padding(.bottom, 124)
            
            ZStack {
                CheckTaskView()
                    .frame(width: 240, height: 240)
                    .onLongPressGesture(minimumDuration: 1) {
                        withAnimation(.easeIn(duration: 1).speed(1)) {
                            opacityFirstInnerTasks = 1
                        }
                        withAnimation(.easeIn(duration: 2).delay(1)) {
                            opacitySecondInnerTasks = 1
                        }
                        withAnimation(.easeIn(duration: 2).delay(2)) {
                            opacityThirdInnerTasks = 1
                        }
                    }
                
                CheckTaskView()
                    .foregroundStyle(Color(hex: "333333"))
                    .frame(width: 180, height: 180)
                    .opacity(opacityFirstInnerTasks)
                
                CheckTaskView()
                    .foregroundStyle(Color(hex: "5B5B5B"))
                    .frame(width: 120, height: 120)
                    .opacity(opacitySecondInnerTasks)

                
                CheckTaskView()
                    .foregroundStyle(Color(hex: "8D8D8D"))
                    .frame(width: 60, height: 60)
                    .opacity(opacityThirdInnerTasks)

            }
            .shadow(color: opacityThirdInnerTasks == 1 ? .black.opacity(0.5) : .clear, radius: 36)
            
            Button {
                
            } label: {
                Text("Detail")
                    .font(.oswald(.regular, size: 20))
                    .underline()
            }
            
            Spacer()
            
            Button {
                
            } label: {
                HStack {
                    Text("+")
                        .font(.oswald(.regular, size: 36))
                    
                    Text("Add Task")
                        .font(.oswaldTitle2)
                }
                .foregroundStyle(.background)
                .padding(.horizontal, 16)
                .background(.black)
                .cornerRadius(30)
            }
            .padding(.bottom)
        }
        .tint(.black)
        .onAppear {
            taskListViewModel.getTasks()
        }
    }
}

#Preview {
    let repository = TaskListRepositoryImpl()
    let useCase = TaskListUseCaseImpl(repository: repository)
    let viewModel = TaskListViewModel(useCase: useCase)
    
    return TaskListView(taskListViewModel: viewModel)
}
