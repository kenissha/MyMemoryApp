import Foundation
import FirebaseAuth // Firebase Auth servisini kullanmak için

// Bu sınıf, tüm Firebase kimlik doğrulama işlemlerini yönetecek.
class AuthService {
    
    // Kullanıcı kaydı fonksiyonu
    func register(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            // İşlem bittiğinde, hatayı (varsa) geri döndür.
            completion(error)
        }
    }
    
    // Kullanıcı giriş fonksiyonu
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            // İşlem bittiğinde, hatayı (varsa) geri döndür.
            completion(error)
        }
    }
}
