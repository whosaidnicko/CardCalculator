import SwiftUI

struct SelectCardSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedSuit: CardSuit = .spades
    @Binding var selectedCard: Card?
    
    let disabledCards: [Card]
    
    var body: some View {
        sheetView
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: 0x2E2E30))
            .presentationDetents([.fraction(0.6)])
    }
    
    var sheetView: some View {
        VStack(spacing: 22.adoption()) {
            cardSuitSelector
                .padding(.horizontal, 36.adoption())
                .padding(.top, 30.adoption())
            
            cardsGrid()
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    private var cardSuitSelector: some View {
        HStack {
            ForEach(CardSuit.allCases, id: \.self) { suit in
                Button(action: {
                    withAnimation(.spring()) {
                        selectedSuit = suit
                    }
                }, label: {
                    Image(suit.getIcon())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50.adoption(), height: 60.adoption())
                        .frame(maxWidth: .infinity)
                        .opacity(selectedSuit == suit ? 1 : 0.5)
                })
            }
        }
    }
    
    @ViewBuilder
    private func cardsGrid() -> some View {
        let columns = [GridItem.init(.flexible()), GridItem.init(.flexible()), GridItem.init(.flexible()), GridItem.init(.flexible()), GridItem.init(.flexible())]
        
        LazyVGrid(columns: columns) {
            ForEach(selectedSuit.getCards(), id: \.self) { card in
                Button(action: {
                    selectedCard = card
                    dismiss()
                }, label: {
                    Image(card.getImageName())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64.adoption(), height: 97.adoption())
                        .frame(maxWidth: .infinity)
                })
                .opacity(disabledCards.contains(card) ? 0.6 : 1)
                .disabled(disabledCards.contains(card))
            }
        }
        .padding(.horizontal, 15.adoption())
    }
}

#Preview {
    Text("")
        .sheet(isPresented: .constant(true)) {
            SelectCardSheetView(selectedCard: .constant(Card(suit: .clubs, value: .ace)), disabledCards: [])
        }
}
