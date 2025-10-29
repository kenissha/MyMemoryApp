// AppState.swift dosyası

import Foundation
import Combine
import FirebaseAuth

// Hata çözümü: ObservableObject protokolünü ekleyin!
class AppState: ObservableObject {
    
    // Değişkenlerinizin başında '@Published' olduğundan emin olun.
    @Published var isAuthenticated = false

    init() {
        if Auth.auth().currentUser != nil {
            isAuthenticated = true
        }
    }
}
