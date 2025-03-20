import SwiftUI

struct CellModifier: ViewModifier {
    func body(content: Content) -> some View {
         content
             .padding(16.adoption())
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
             .cornerRadius(12.adoption())
     }
 }

 extension View {
     func cellModifier() -> some View {
         self.modifier(CellModifier())
     }
 }
