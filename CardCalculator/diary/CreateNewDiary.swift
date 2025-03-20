import SwiftUI

fileprivate enum FocusedField {
    case amount, duration, hands, notes
}

struct CreateNewDiary: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var createVM = CreateNewDiaryVM()
    @FocusState fileprivate var isFocused: FocusedField?
    
    var gameEntity: GameEntity? = nil
    
    var body: some View {
        VStack(spacing: 24.adoption()) {
            header
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16.adoption()) {
                    ZStack {
                        VStack(spacing: 16.adoption()) {
                            gameType
                                .zIndex(10)
                            
                            sessionResult
                                .zIndex(5)
                            
                            amount
                                .zIndex(5)
                        }
                    }
                    .cellModifier()
                    
                    ZStack {
                        VStack(spacing: 16.adoption()) {
                            duration
                                .zIndex(5)
                            
                            tableType
                                .zIndex(10)
                            
                            handsPlayed
                                .zIndex(5)
                            
                            notes
                                .zIndex(5)
                        }
                    }
                    .cellModifier()
                    .padding(.bottom, 8.adoption())
                    
                    VStack(spacing: 12.adoption()) {
                        MainButtonView(title: gameEntity == nil ? "Save Session" : "Update Session", icon: nil, action: {
                            createVM.saveAction(gameEntity: gameEntity)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { presentationMode.wrappedValue.dismiss() }
                        })
                        
                        SecondaryButtonView(title: "Cancel", icon: nil, action: { presentationMode.wrappedValue.dismiss() })
                        
                        if gameEntity != nil {
                            DestructiveButton(title: "Delete Session", icon: nil, action: {
                                createVM.deleteAction(gameEntity: gameEntity)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { presentationMode.wrappedValue.dismiss() }
                            })
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 16.adoption())
        .background(Color.backgroundColor)
        .onTapGesture {
            if isFocused != nil { isFocused = nil }
        }
        .onAppear {
            guard let gameEntity else { return }
            createVM.selectedGameType = GameType.from(rawValue: gameEntity.gameType ?? "") ?? .texas
            createVM.isWinning = gameEntity.isWinning
            createVM.amount = "\(gameEntity.amount)"
            createVM.duration = "\(gameEntity.duration)"
            createVM.selectedTableType = TableType.from(rawValue: gameEntity.tableType ?? "") ?? .cash
            createVM.hands = "\(gameEntity.hands)"
            createVM.notes = gameEntity.notes ?? ""
        }
    }
}

extension CreateNewDiary {
    private var header: some View {
        HStack {
            Button(action: { presentationMode.wrappedValue.dismiss() }, label: {
                Image(.arrowBack)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18.adoption(), height: 18.adoption())
            })
            
            Text("Add New Session")
                .font(Font.custom("Aldrich", size: 18.adoption()))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
        }
        .padding(.top, 12.adoption())
    }
    
    private var gameType: some View {
        VStack(spacing: 12.adoption()) {
            sectionTitle("Game Type")
            
            SelectEnumField(selectedType: $createVM.selectedGameType)
        }
    }
    
    private var sessionResult: some View {
        VStack(spacing: 12.adoption()) {
            sectionTitle("Session Result")
         
            HStack(spacing: 12.adoption()) {
                Button(action: { createVM.isWinning = true }, label: {
                    sesionResultButton(isWinning: true, isSelected: createVM.isWinning == true)
                })
                
                Button(action: { createVM.isWinning = false }, label: {
                    sesionResultButton(isWinning: false, isSelected: createVM.isWinning == false)
                })
            }
        }
    }
    
    private var amount: some View {
        VStack(spacing: 12.adoption()) {
            sectionTitle("Amount")
         
            FieldOfText(text: $createVM.amount, placeholder: "Enter amount", hasDollar: true)
                .keyboardType(.numberPad)
                .focused($isFocused, equals: .amount)
        }
    }
    
    private var duration: some View {
        VStack(spacing: 12.adoption()) {
            sectionTitle("Duration")
         
            FieldOfText(text: $createVM.duration, placeholder: "Input")
                .keyboardType(.numberPad)
                .focused($isFocused, equals: .duration)
        }
    }
    
    private var tableType: some View {
        VStack(spacing: 12.adoption()) {
            sectionTitle("Table Type")
            
            SelectEnumField(selectedType: $createVM.selectedTableType)
        }
    }
    
    
    private var handsPlayed: some View {
        VStack(spacing: 12.adoption()) {
            sectionTitle("Hands Played")
         
            FieldOfText(text: $createVM.hands, placeholder: "Number of hands")
                .keyboardType(.numberPad)
                .focused($isFocused, equals: .hands)
        }
    }
    
    private var notes: some View {
        VStack(spacing: 12.adoption()) {
            sectionTitle("Notes")
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $createVM.notes)
                    .font(.aldrich(16.adoption()))
                    .padding(.horizontal, 12.adoption())
                    .frame(height: 96.adoption())
                    .scrollContentBackground(.hidden)
                    .background(.white.opacity(0.1))
                    .cornerRadius(8.adoption())
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.29, green: 0.33, blue: 0.39), lineWidth: 1)
                    )
                    .autocorrectionDisabled()
                    .focused($isFocused, equals: .notes)
                    .tint(.white)
                
                if createVM.notes.isEmpty && isFocused != .notes {
                   Text("Add session notes...")
                        .font(.aldrich(16.adoption()))
                       .foregroundStyle(Color(hex: 0x787878).opacity(0.7))
                       .padding(12.adoption())
                }
            }
        }
    }
    
    @ViewBuilder
    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(Font.custom("Aldrich", size: 14.adoption()))
            .lineLimit(1)
            .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func sesionResultButton(isWinning: Bool, isSelected: Bool) -> some View {
        HStack {
            Image(isWinning ? .winningIcon : .losingIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 18.adoption(), height: 18.adoption())
            
            Text(isWinning ? "Winning" : "Losing")
                .font(Font.custom("Aldrich", size: 14.adoption()))
                .lineLimit(1)
                .foregroundColor(isSelected ? Color.white : Color(red: 0.61, green: 0.64, blue: 0.69))
        }
        .padding(.vertical, 16.adoption())
        .frame(maxWidth: .infinity)
        .background {
            Group {
                isWinning ? LinearGradient.greenGradient : LinearGradient.redGradient
            }
            .opacity(isSelected ? 1 : 0)
        }
        .background(Color.white.opacity(0.1))
        .cornerRadius(8.adoption())
    }
}

#Preview {
    CreateNewDiary()
}
