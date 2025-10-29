import SwiftUI

struct ContentView: View {
    
    // Uygulama genel durumunu dinle ve tüm alt görünümlere aktar
    @StateObject var appState = AppState()

    var body: some View {
        Group {
            if appState.isAuthenticated {
                // Eğer giriş yapıldıysa: Harita Ekranını göster (Şimdilik sadece bir metin)
                Text("HOŞ GELDİNİZ! (Harita Ekranı)")
            } else {
                // Giriş yapılmadıysa: Kimlik doğrulama ekranını göster
                AuthView()
            }
        }
        // AppState'i tüm alt görünümlere (AuthView dahil) erişilebilir yap
        .environmentObject(appState)
    }
}

#Preview {
    ContentView()
}
