//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Quevin Bambasi on 3/26/23.
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
