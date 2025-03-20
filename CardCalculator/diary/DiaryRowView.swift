import SwiftUI

struct DiaryRowView: View {
    
    let gameEntity: GameEntity?
    @State private var isLinkOpen: Bool = false
    
    var body: some View {
        Button(action: { isLinkOpen = true }, label: {
            bodyContent
        })
        .navigationDestination(isPresented: $isLinkOpen, destination: {
            CreateNewDiary(gameEntity: gameEntity)
                .navigationBarBackButtonHidden()
        })
    }
    
    func formattedDate(date: Date) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: date)
    }
    
    var bodyContent: some View {
        VStack(spacing: 0) {
            HStack {
                let gameType = gameEntity?.gameType ?? GameType.texas.rawValue
                Text(gameType)
                    .font(Font.custom("Aldrich", size: 14.adoption()))
                    .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                let price = gameEntity?.amount ?? 0
                let isWinning = gameEntity?.isWinning ?? false
                Text("\(isWinning ? "+" : "-")$\(price)")
                    .font(Font.custom("Aldrich", size: 16.adoption()))
                    .foregroundColor(isWinning ? Color.appGreen : Color(hex: 0xEF4444))
                    .frame(alignment: .trailing)
            }
            .padding(.bottom, 3.adoption())
            
            let duration = gameEntity?.duration ?? 0
            Text("\(formattedDate(date: gameEntity?.date ?? Date())) • \(String(format: "%.1f", duration))h")
                .font(Font.custom("Aldrich", size: 12.adoption()))
                .foregroundColor(Color(red: 0.42, green: 0.45, blue: 0.5))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 14.adoption())
            
            HStack {
                let hands = gameEntity?.hands ?? 0
                Text("Hands played: \(hands)")
                    .font(Font.custom("Aldrich", size: 12.adoption()))
                    .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .fontWeight(.semibold)
                    .foregroundStyle(LinearGradient.greenGradient)
                    .frame(width: 14.adoption(), height: 14.adoption())
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cellModifier()
    }
}

#Preview {
    DiaryRowView(gameEntity: nil)
}
