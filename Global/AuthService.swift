
import Foundation
import FirebaseCore
import FirebaseAuth


class AuthService: ObservableObject {
    
    @Published var signedIn: Bool = false
    
    init() {
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.signedIn = true
                print("Auth state changed, is signed in")
            } else {
                self.signedIn = false
                print("Auth state changed, is signed out")
            }
        }
    }

    func regularCreateAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
                
            } else {
                print("Successfully created password account")
            }
        }
    }


    func regularSignIn(email:String, password:String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
            if let e = error {
                completion(e)
            } else {
                print("Login success")
                completion(nil)
            }
        }
    }


    func regularSignOut(completion: @escaping (Error?) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completion(nil)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
          completion(signOutError)
        }
    }
    
}
