import SwiftUI

fileprivate enum FocusedField {
    case login, password
}

struct LoginView: View {
    @State private var isLoading: Bool = false
    
    
    @StateObject var loginVM: LoginViewModel = .init()
    @FocusState fileprivate var isFocused: FocusedField?
    
    var body: some View {
        if loginVM.isLoading {
            LoaderView(isLoading: $loginVM.isLoading)
        } else {
            bodyContent
        }
    }
    
    var bodyContent: some View {
        VStack(spacing: 0) {
            Image(.applicationLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 220.adoption(), height: 175.adoption())
                .padding(.bottom, 35.adoption())
            
            Group {
                switch loginVM.currentPage {
                case .login:
                    loginBlock
                case .signup:
                    signinBlock
                }
            }
            .padding(16.adoption())
            .background(LinearGradient.grayGradient)
            .cornerRadius(12.adoption())
            
            Spacer()
            
            
            SecondaryButtonView(title: loginVM.currentPage == .login ? "Register" : "Log in",
                                icon: nil, action: {
                withAnimation(.default){
                    if loginVM.currentPage == .login {
                        loginVM.currentPage = .signup
                    } else {
                        loginVM.currentPage = .login
                    }
                }
            })
            .padding(.bottom, 10.adoption())
            .disabled(isLoading)
        }
        .padding(.horizontal, 16.adoption())
        .padding(.top, 50.adoption())
        .background(LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 0.11, green: 0.11, blue: 0.11), location: 0.50),
                Gradient.Stop(color: Color(red: 0.11, green: 0.11, blue: 0.11), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1)
        ))
        .onTapGesture {
            if isFocused != nil { isFocused = nil }
        }
    }
    
    private var loginBlock: some View {
        VStack(spacing: 12.adoption()) {
            Text("Email")
              .font(Font.custom("Aldrich", size: 14))
              .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
              .frame(maxWidth: .infinity, alignment: .leading)
            
            FieldOfText(text: $loginVM.login, placeholder: "Enter", isValid: (loginVM.loginEmailValid || loginVM.login.isEmpty))
                .focused($isFocused, equals: .login)
            
            Text("Password")
              .font(Font.custom("Aldrich", size: 14))
              .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
              .frame(maxWidth: .infinity, alignment: .leading)
            
            FieldOfText(text: $loginVM.password, placeholder: "Enter", isSecured: true)
                .focused($isFocused, equals: .password)
                .padding(.bottom, 8.adoption())
            
            MainButtonView(title: "Login", icon: nil, action: {
                isLoading = true
            
            })
            .disabled((!loginVM.isLoginValid) || isLoading)
            .opacity((!loginVM.isLoginValid) || isLoading ? 0.6 : 1)
        }
    }
    
    private var signinBlock: some View {
        VStack(spacing: 12.adoption()) {
            Text("Name")
              .font(Font.custom("Aldrich", size: 14))
              .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
              .frame(maxWidth: .infinity, alignment: .leading)
            
            FieldOfText(text: $loginVM.createName, placeholder: "Enter")
                .focused($isFocused, equals: .login)
            
            Text("Email")
              .font(Font.custom("Aldrich", size: 14))
              .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
              .frame(maxWidth: .infinity, alignment: .leading)
            
            FieldOfText(text: $loginVM.createLogin, placeholder: "Enter", isValid: (loginVM.emailValid || loginVM.createLogin.isEmpty))
                .focused($isFocused, equals: .login)
            
            Text("Password")
              .font(Font.custom("Aldrich", size: 14))
              .foregroundColor(Color(red: 0.61, green: 0.64, blue: 0.69))
              .frame(maxWidth: .infinity, alignment: .leading)
            
            FieldOfText(text: $loginVM.createPassword, placeholder: "Enter", isSecured: true)
                .focused($isFocused, equals: .password)
                .padding(.bottom, 8.adoption())
            
            MainButtonView(title: "Sign Up", icon: nil, action: {
                isLoading = true
              
                AppSettings.shared.name = loginVM.createName
                AppSettings.shared.login = loginVM.createLogin
            })
            .disabled((!loginVM.signUpValid) || isLoading)
            .opacity((!loginVM.signUpValid) || isLoading ? 0.6 : 1)
        }
    }
}

#Preview {
    LoginView()
}
