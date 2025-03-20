import SwiftUI

struct SelectEnumField<T: RawRepresentable & CaseIterable>: View where T.RawValue == String {
    @Binding var selectedType: T
    
    @State private var isOpened: Bool = false
    
    var body: some View {
        Button(action: { isOpened.toggle() }, label: {
            HStack(spacing: 8.adoption()) {
                Text(selectedType.rawValue)
                    .font(.aldrich(16.adoption()))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: isOpened ? "chevron.up" : "chevron.down")
                    .resizable()
                    .scaledToFit()
                    .fontWeight(.semibold)
                    .frame(width: 13.adoption(), height: 13.adoption())
            }
            .foregroundStyle(Color.white)
            .padding(.horizontal, 12.adoption())
            .frame(height: 50.adoption())
            .background(.white.opacity(0.1))
            .cornerRadius(8.adoption())
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.5)
                    .stroke(isOpened ? Color.white : Color(red: 0.29, green: 0.33, blue: 0.39), lineWidth: 1)
            )
        })
        .overlay(alignment: .top) {
             if isOpened {
                VStack(spacing: 12.adoption()) {
                    Button(action: {
                        isOpened = false
                    }, label: {
                        Text(selectedType.rawValue)
                            .font(.aldrich(16.adoption()))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    })
                    
                    Rectangle()
                        .foregroundStyle(Color.white.opacity(0.4))
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                    
                    ForEach(Array(T.allCases), id: \.rawValue) { type in
                        if type.rawValue != selectedType.rawValue {
                            Button(action: {
                                selectedType = type
                                isOpened = false
                            }, label: {
                                Text(type.rawValue)
                                    .font(.aldrich(16.adoption()))
                                    .foregroundStyle(Color.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            })
                        }
                    }
                }
                .padding(.horizontal, 8.adoption())
                .padding(.vertical, 16.adoption())
                .frame(height: 172.adoption(), alignment: .top)
                .frame(maxWidth: .infinity)
                .background(.white.opacity(0.1))
                .background(.ultraThickMaterial)
                .cornerRadius(8.adoption())
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 0.5)
                        .stroke(.white, lineWidth: 1)
                )
                .offset(y: 55.adoption())
            }
        }
    }
}

#Preview {
    SelectEnumField(selectedType: .constant(GameType.texas))
}
