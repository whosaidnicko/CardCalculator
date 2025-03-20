import Foundation

enum LoginPage {
    case login, signup
}

class LoginViewModel: ObservableObject {
    
    @Published var currentPage: LoginPage = .login
    @Published var isLoading: Bool = true

    @Published var login: String = ""
    @Published var password: String = ""

    @Published var createName: String = ""
    @Published var createLogin: String = ""
    @Published var createPassword: String = ""
    
    var isLoginValid: Bool {
        login.trimmingCharacters(in: .whitespacesAndNewlines).count > 5 &&
        password.trimmingCharacters(in: .whitespacesAndNewlines).count > 5 &&
        loginEmailValid
    }
    
    var signUpValid: Bool {
        createName.trimmingCharacters(in: .whitespacesAndNewlines).count > 3 &&
        createLogin.trimmingCharacters(in: .whitespacesAndNewlines).count > 5 &&
        createPassword.trimmingCharacters(in: .whitespacesAndNewlines).count > 5 &&
        emailValid
    }
    
    var loginEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: login.trimmingCharacters(in: .whitespaces))
    }
    
    var emailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: createLogin.trimmingCharacters(in: .whitespaces))
    }
}
