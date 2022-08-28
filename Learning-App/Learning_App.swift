//
//  Learning_App.swift
//  Learning-App
//
//  Created by Prisha Anand on 8/28/22.
//

import SwiftUI

@main
struct Learning_App: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}

