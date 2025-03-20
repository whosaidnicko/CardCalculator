import SwiftUI

struct DiaryView: View {
    
    @State private var isCreateDiaryViewOpen: Bool = false
    @StateObject var storage = StorageViewModel.shared
    
    @State private var total: Int = 0
    @State private var avgSession: Int = 0
    @State private var sessions: Int = 0
    @State private var winsRate: Double = 0
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: "Diary", plusAction: { isCreateDiaryViewOpen = true })
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12.adoption()) {
                    totalBalance
                        .padding(.bottom, 12.adoption())
                    
                        Text("Recent Sessions")
                            .font(Font.custom("Aldrich", size: 18.adoption()))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 12.adoption())
                        
                        ForEach(storage.savedGames, id: \.id) { game in
                            DiaryRowView(gameEntity: game)
                        }
                }
                .padding(.vertical, 35.adoption())
            }
            .padding(.horizontal, 16.adoption())
        }
        .task {
            calculate()
        }
        .navigationDestination(isPresented: $isCreateDiaryViewOpen, destination: {
            CreateNewDiary()
                .navigationBarBackButtonHidden()
        })
    }
    
    private var totalBalance: some View {
        VStack(spacing: 16.adoption()) {
            HStack {
                Text("Total Balance")
                    .font(Font.custom("Aldrich", size: 14.adoption()))
                    .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
                  
                Text("\(total > 0 ? "+" : "-")$\(abs(total))")
                    .font(Font.custom("Aldrich", size: 16.adoption()))
                    .foregroundColor(Color(red: 0.47, green: 0.95, blue: 0.5))
                    .frame(alignment: .trailing)
            }
            
            HStack {
                getStatisticsCol(title: "Sessions", value: "\(storage.savedGames.count)")
                    .frame(maxWidth: .infinity)
                
                getStatisticsCol(title: "Win Rate", value: "\(String(format: "%.0f", winsRate))%", valueGradient: true)
                    .frame(maxWidth: .infinity)
                
                getStatisticsCol(title: "Avg/Session", value: "\(avgSession)")
                    .frame(maxWidth: .infinity)
            }
        }
        .cellModifier()
    }
    
    private func calculate() {
        self.sessions = storage.savedGames.count
        self.winsRate = (Double(storage.savedGames.filter { $0.isWinning }.count) / (Double(sessions) == 0 ? 1 : Double(sessions))) * 100
        self.total = Int(storage.savedGames.reduce(0, { result, game in result + ( game.isWinning ? game.amount : -game.amount) }))
        self.avgSession = Int(Double(total) / (Double(sessions) == 0 ? 1 : Double(sessions)))
    }
    
    private func getStatisticsCol(title: String, value: String, valueGradient: Bool = false) -> some View {
        VStack(spacing: 7.adoption()) {
            Text(title)
                .font(Font.custom("Aldrich", size: 12.adoption()))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
            
            if valueGradient {
                Text(value)
                    .font(Font.custom("Aldrich", size: 18.adoption()))
                    .foregroundStyle(LinearGradient.greenGradient)
            } else {
                Text(value)
                    .font(Font.custom("Aldrich", size: 18.adoption()))
                    .foregroundStyle(Color.white)
            }
        }
    }
}

#Preview {
    DiaryView()
}
