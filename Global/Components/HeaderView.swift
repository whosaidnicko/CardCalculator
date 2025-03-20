import SwiftUI

struct HeaderView: View {
    
    let title: String
    var plusAction: (()->Void)? = nil
    var backAction: (()->Void)? = nil
    
    var body: some View {
        HStack {
            if let backAction {
                Button(action: backAction, label: {
                    Image(.arrowBack)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18.adoption(), height: 18.adoption())
                })
            } else if plusAction != nil {
                Spacer()
                    .frame(width: 18.adoption(), height: 18.adoption())
            }
            
            Text(title)
                .font(Font.custom("Aldrich", size: 18.adoption()))
                .lineLimit(1)
                .foregroundColor(.white)
                .padding(.top, UIDevice.isSmallIphone ? 40.adoption() : 20.adoption())
                .padding(.bottom, 17.adoption())
                .frame(maxWidth: .infinity)
            
            if backAction != nil {
                Spacer()
                    .frame(width: 18.adoption(), height: 18.adoption())
            } else if let plusAction {
                Button(action: plusAction, label: {
                    Image(.plusIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18.adoption(), height: 18.adoption())
                })
            }
        }
        .padding(.horizontal, 16.adoption())
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.24, green: 0.24, blue: 0.24), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.19, green: 0.18, blue: 0.2), location: 0.50),
                    Gradient.Stop(color: Color(red: 0.18, green: 0.18, blue: 0.19), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
        )
    }
}

#Preview {
    HeaderView(title: "String")
    HeaderView(title: "String", plusAction: {})
    HeaderView(title: "String", backAction: {})
}
