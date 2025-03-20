import SwiftUI

struct CalcView: View {
    @StateObject var calculatorVM = CalculatorViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: "Calc")
            
            VStack(spacing: 12.adoption()) {
                sectionTitle("Your Cards")
                
                HStack(spacing: 8.adoption()) {
                    ForEach(calculatorVM.myCards.indices, id: \.self) { index in
                        CardItemView(selectedCard: Binding(get: {
                            calculatorVM.myCards[index]
                        }, set: { newValue in
                            calculatorVM.myCards[index] = newValue
                        }), disabledCards: calculatorVM.myCards.compactMap { $0 } + calculatorVM.tableCards.compactMap { $0 })
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 15.adoption())
                
                sectionTitle("Table Cards")
                
                HStack(spacing: 8.adoption()) {
                    ForEach(calculatorVM.tableCards.indices, id: \.self) { index in
                        CardItemView(isGray: true, selectedCard: Binding(get: {
                            calculatorVM.tableCards[index]
                        }, set: { newValue in
                            calculatorVM.tableCards[index] = newValue
                        }), disabledCards: calculatorVM.myCards.compactMap { $0 } + calculatorVM.tableCards.compactMap { $0 })
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 20.adoption())
                
                let isValid = calculatorVM.myCards.compactMap{$0}.count == 2 && calculatorVM.tableCards.compactMap{$0}.count >= 3
                MainButtonView(title: "Calculate Probability", icon: nil, action: {
                    calculatorVM.calculateAction()
                })
                .disabled(!isValid)
                .opacity(!isValid ? 0.6 : 1)
                
                statisticsBlock
            }
            .padding(16.adoption())
            .padding(.top, 3.adoption())
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    private var statisticsBlock: some View {
        VStack(spacing: 0) {
            HStack {
                getStatisticsCol(title: "Win Probability", value: "\(String(format: "%.1f", calculatorVM.winningProbability * 100))%", color: Color.appGreen, alignment: .leading)
                    .frame(width: 130.adoption(), alignment: .leading)
                
                getStatisticsCol(title: "Draw", value: "\(String(format: "%.1f", calculatorVM.draw * 100))%", color: Color.white, alignment: .leading)
                    .frame(maxWidth: .infinity)
                
                getStatisticsCol(title: "Loss", value: "\(String(format: "%.1f", calculatorVM.losing * 100))%", color: Color(red: 0.94, green: 0.27, blue: 0.27), alignment: .trailing)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.bottom, 20.adoption())
            
            Text("Possible Hands")
                .font(Font.custom("Aldrich", size: 14.adoption()))
                .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.bottom, 15.adoption())
            
            getStatisticsRow(title: "Flush Draw", value: "\(String(format: "%.1f", calculatorVM.flush * 100))%")
                .padding(.bottom, 11.adoption())
            
            getStatisticsRow(title: "Straight", value: "\(String(format: "%.1f", calculatorVM.straight * 100))%")
                .padding(.bottom, 11.adoption())
            
            getStatisticsRow(title: "Two Pair", value: "\(String(format: "%.1f", calculatorVM.twoPairs * 100))%")
        }
        .cellModifier()
    }
    
    @ViewBuilder
    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(Font.custom("Aldrich", size: 14.adoption()))
            .lineLimit(1)
            .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func getStatisticsCol(title: String, value: String, color: Color, alignment: HorizontalAlignment = .center) -> some View {
        VStack(alignment: alignment, spacing: 9.adoption()) {
            Text(title)
                .font(Font.custom("Aldrich", size: 14.adoption()))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
            
            Text(value)
                .font(Font.custom("Aldrich", size: 24.adoption()))
                .foregroundStyle(color)
        }
    }
    
    private func getStatisticsRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(Font.custom("Aldrich", size: 14.adoption()))
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(value)
                .font(Font.custom("Aldrich", size: 14.adoption()))
                .foregroundStyle(LinearGradient.greenGradient)
        }
    }
}

#Preview {
    CalcView()
}
