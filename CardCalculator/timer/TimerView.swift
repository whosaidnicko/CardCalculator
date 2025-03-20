import SwiftUI

import SwiftUI

struct TimerView: View {
    @ObservedObject var tabbarVM = TabbarViewModel.shared
    @StateObject private var viewModel = TimerViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: "Tournament Timer", backAction: {
                withAnimation(.default) { tabbarVM.selectedTab = tabbarVM.previousSelectedTab }
            })
            
            VStack(spacing: 24.adoption()) {
                timerBlock
                tournamentBlock
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 24.adoption())
            .padding(.vertical, 32.adoption())
            
            HStack {
                SecondaryButtonView(title: "Setup", icon: .toolsIcon) {
                    tabbarVM.selectedTab = .settings
                }
                
                if viewModel.isRunning {
                    DestructiveButton(title: "Stop", icon: .stopIcon) {
                        viewModel.stopTimer()
                    }
                } else {
                    MainButtonView(title: "Start", icon: .playIcon) {
                        viewModel.startTimer()
                    }
                }
            }
            .padding(.bottom, UIDevice.isSmallIphone ? 10 : 30.adoption())
            .cellModifier()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

extension TimerView {
    private var timerBlock: some View {
        VStack(spacing: 0) {
            Text("Current Level")
                .font(Font.custom("Aldrich", size: 16.adoption()))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
                .padding(.bottom, 14.adoption())
            
            Text(viewModel.formattedTime(viewModel.currentTime))
                .font(Font.custom("Aldrich", size: 60.adoption()))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.47, green: 0.95, blue: 0.5))
                .padding(.bottom, 34.adoption())
            
            HStack {
                VStack(alignment: .leading, spacing: 7.adoption()) {
                    Text("Next Level In")
                        .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
                    
                    Text(viewModel.formattedTime(viewModel.nextLevelTime))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .trailing, spacing: 7.adoption()) {
                    Text("Total Time")
                        .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
                    
                    Text(viewModel.formattedTime(viewModel.totalTime))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .font(Font.custom("Aldrich", size: 14.adoption()))
        }
        .cellModifier()
    }
    
    private var tournamentBlock: some View {
        VStack(spacing: 0) {
            Text("Current Blinds")
                .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
                .padding(.bottom, 12.adoption())
            
            Text(viewModel.currentBlinds)
                .font(Font.custom("Aldrich", size: 30.adoption()))
                .foregroundColor(.white)
                .padding(.bottom, 32.adoption())

            Text("Next Level")
                .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
                .padding(.bottom, 8.adoption())
            
            Text(viewModel.nextBlinds)
                .foregroundColor(.white)
        }
        .font(Font.custom("Aldrich", size: 16.adoption()))
        .frame(maxWidth: .infinity)
        .cellModifier()
    }
}

#Preview {
    TimerView()
}
