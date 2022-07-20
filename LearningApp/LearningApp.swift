//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Andy on 7/20/22.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
