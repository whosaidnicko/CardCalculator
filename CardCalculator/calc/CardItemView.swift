import SwiftUI

struct CardItemView: View {
    
    var isGray: Bool = false
    
    @Binding var selectedCard: Card?
    
    @State private var isSheetOpen: Bool = false
    let disabledCards: [Card]
    
    var body: some View {
        Button(action: { isSheetOpen = true }, label: {
            bodyContent
        })
        .overlay(alignment: .topTrailing, content: {
            if selectedCard != nil {
                Button(action: { selectedCard = nil }, label: {
                    Image(.xmark)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 17.adoption(), height: 17.adoption())
                })
                .offset(x: 5.adoption(), y: -5.adoption())
            }
        })
        .sheet(isPresented: $isSheetOpen) {
            SelectCardSheetView(selectedCard: $selectedCard, disabledCards: disabledCards)
        }
    }
    
    var bodyContent: some View {
        Group {
            if let selectedCard {
                Image(selectedCard.getImageName())
                    .resizable()
                    .scaledToFill()
            } else {
                Image(.plusIcon)
                    .renderingMode(isGray ? .template : .original)
                    .foregroundStyle(Color.appGray)
                    .scaledToFit()
                    .frame(width: 21.adoption(), height: 24.adoption())
            }
        }
        .frame(width: 64.adoption(), height: 96.adoption())
        .background(
            LinearGradient.grayGradient
        )
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .inset(by: 1)
                .stroke(isGray ? Color(hex: 0x374151) : Color.appGreen, lineWidth: 2)
        )
    }
}

#Preview {
    CardItemView(selectedCard: .constant(Card(suit: .clubs, value: .ace)), disabledCards: [])
    CardItemView(selectedCard: .constant(nil), disabledCards: [])
}
