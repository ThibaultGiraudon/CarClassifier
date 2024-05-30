//
//  CarClassifierApp.swift
//  CarClassifier
//
//  Created by Thibault Giraudon on 30/05/2024.
//

import SwiftUI

@main
struct CarClassifierApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(classifier: ImageClassifier())
        }
    }
}
