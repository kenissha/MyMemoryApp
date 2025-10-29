//
//  MemorymApp.swift
//  Memorym
//
//  Created by Rifat Ozturk on 29.10.2025.
//

import SwiftUI
import Firebase 

@main
struct MemorymApp: App {
    
    init() {
            FirebaseApp.configure() // <-- Bu fonksiyonu ekleyin!
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
