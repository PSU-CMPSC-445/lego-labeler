//
//  LegoLabelerApp.swift
//  LegoLabeler
//
//  Created by Edward Lach on 3/13/21.
//

import SwiftUI
import GoogleSignIn

@main
struct LegoLabelerApp: App {
    
    init() {
        GIDSignIn.sharedInstance().clientID = "1029841373574-dtk4bjpbhttpmk15d1dki1l4sr4ou1rp.apps.googleusercontent.com"
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
