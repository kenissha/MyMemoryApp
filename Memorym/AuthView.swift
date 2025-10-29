import SwiftUI
import UIKit // UIColor ve klavye tiplerini kullanmak için
import FirebaseAuth // Sadece print'i temizlemek için ekledik, gerekli değil ama kalması zarar vermez.

struct AuthView: View {
    
    // AppState'i dinleyerek ana akışı değiştireceğiz
    @EnvironmentObject var appState: AppState
    
    // Auth servisini çağırabilmek için tanımlama
    private let authService = AuthService()
    
    // Kullanıcı girişleri için durum değişkenlerisssss
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false // Kayıt/Giriş modu kontrolü için
    
    // Hata mesajı göstermek için durum değişkenleri
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            
            // --- Başlık ---
            Text(isRegistering ? "Yeni Hesap Oluştur" : "Giriş Yap")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            // --- E-posta Alanı ---
            TextField("E-posta", text: $email)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never) // Otomatik büyük harfi kapat

            // --- Şifre Alanı ---
            SecureField("Şifre", text: $password)
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            
            // --- Ana Buton ---
            Button(action: {
                // E-posta ve şifrenin boş olup olmadığını kontrol et
                guard !email.isEmpty, !password.isEmpty else {
                    alertMessage = "Lütfen e-posta ve şifre alanlarını doldurun."
                    showingAlert = true
                    return
                }
                
                if isRegistering {
                    // KAYIT OLMA İŞLEMİ
                    authService.register(email: email, password: password) { error in
                        if let error = error {
                            alertMessage = error.localizedDescription
                            showingAlert = true
                        } else {
                            alertMessage = "Kayıt başarılı! Şimdi giriş yapabilirsiniz."
                            showingAlert = true
                            isRegistering = false // Giriş moduna geç
                            email = "" // Alanları temizle
                            password = ""
                        }
                    }
                } else {
                    // GİRİŞ YAPMA İŞLEMİ
                    authService.login(email: email, password: password) { error in
                        if let error = error {
                            alertMessage = error.localizedDescription
                            showingAlert = true
                        } else {
                            // Giriş başarılı oldu! Akışı değiştir!
                            appState.isAuthenticated = true
                        }
                    }
                }
            }) {
                Text(isRegistering ? "Kayıt Ol" : "Giriş Yap")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.vertical, 10)

            // --- Mod Değiştirme Butonu ---
            Button(action: {
                // Modu değiştir ve alanları temizle
                isRegistering.toggle()
                email = ""
                password = ""
            }) {
                Text(isRegistering ? "Zaten hesabım var, Giriş Yap" : "Hesabım yok, Kayıt Ol")
                    .foregroundColor(.blue)
            }
            
        }
        .padding()
        // Hata olduğunda göstermek için uyarı (alert)
        .alert("Mesaj", isPresented: $showingAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
}

#Preview {
    // Preview'in de AppState'e ihtiyacı var
    AuthView()
        .environmentObject(AppState())
}
