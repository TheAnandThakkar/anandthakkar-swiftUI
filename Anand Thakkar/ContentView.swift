//
//  ContentView.swift
//  Anand Thakkar
//
//  Created by Anand Thakkar on 27/09/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            TabView {
                HomeView()
                    .tabItem { Label("Home", systemImage: "house.fill") }

                CertificatesView()
                    .tabItem { Label("Certificates", systemImage: "checkmark.seal.fill") }

                ProjectsView()
                    .tabItem { Label("Projects", systemImage: "hammer.fill") }

                BlogsView()
                    .tabItem { Label("Blogs", systemImage: "text.page.fill") }

                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gearshape.fill") }
            }
        }
    }
}

#Preview {
    ContentView()
}
