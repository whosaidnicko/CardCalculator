import SwiftUI

struct SettingsView: View {
    @ObservedObject private var appSettings = AppSettings.shared
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: "Settings")
            
            VStack(spacing: 16.adoption()) {
                userInfoBlock
                    .padding(.bottom, 8.adoption())
                
                notificationBlock
                
                tournamentBlock()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 24.adoption())
            .padding(.horizontal, 16.adoption())
        }
    }
}

extension SettingsView {
    private var userInfoBlock: some View {
        HStack(spacing: 16.adoption()) {
            ImageBlock()
            
            VStack(alignment: .leading, spacing: 9.adoption()) {
                Text("\(appSettings.name)")
                    .font(Font.custom("Aldrich", size: 18.adoption()))
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(appSettings.login)")
                    .font(Font.custom("Aldrich", size: 14.adoption()))
                    .textSelection(.disabled)
                    .lineLimit(1)
                    .foregroundStyle(Color.appGray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .cellModifier()
    }
    
    private var notificationBlock: some View {
        HStack(spacing: 16.adoption()) {
            Image(.bellIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 16.adoption(), height: 16.adoption())
            
            Text("Notifications")
                .font(Font.custom("Aldrich", size: 16.adoption()))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ToggleView(isOn: $appSettings.isNotificationOn)
        }
        .cellModifier()
    }
    
    @ViewBuilder
    private func tournamentBlock() -> some View {
        VStack(spacing: 16.adoption()) {
            HStack(spacing: 16.adoption()) {
                Image(.clockIcon)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(LinearGradient.greenGradient)
                    .scaledToFit()
                    .frame(width: 16.adoption(), height: 16.adoption())
                    .clipped()
                
                Text("Tournament Timer")
                    .font(Font.custom("Aldrich", size: 16.adoption()))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack(spacing: 8.adoption()) {
                Button(action: {
                    appSettings.tournamentTimer = .fifteen
                }, label: {
                    getTimeCellView(.fifteen, isSelected: appSettings.tournamentTimer.rawValue == TournamentType.fifteen.rawValue)
                })
                
                Button(action: {
                    appSettings.tournamentTimer = .thirdty
                }, label: {
                    getTimeCellView(.thirdty, isSelected: appSettings.tournamentTimer.rawValue == TournamentType.thirdty.rawValue)
                })
                
                Button(action: {
                    appSettings.tournamentTimer = .fourtyFive
                }, label: {
                    getTimeCellView(.fourtyFive, isSelected: appSettings.tournamentTimer.rawValue == TournamentType.fourtyFive.rawValue)
                })
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .cellModifier()
    }
    
    func getTimeCellView(_ timeType: TournamentType, isSelected: Bool) -> some View {
        Text(timeType.rawValue)
            .font(Font.custom("Aldrich", size: 14.adoption()))
            .foregroundColor(.white)
            .padding(.vertical, 8.adoption())
            .padding(.horizontal, 12.adoption())
            .background(LinearGradient.greenGradient.opacity(isSelected ? 1 : 0))
            .background(Color.appBlack)
            .clipShape(.capsule)
          
    }
}

#Preview {
    SettingsView()
}
