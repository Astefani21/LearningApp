//
//  DemoForFirebaseApp.swift
//  DemoForFirebase
//
//  Created by Alexis Willey on 11/30/21.
//

import SwiftUI
import Firebase

@main
struct DemoForFirebaseApp: App {

    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(ContentModel())
        }
    }
}
