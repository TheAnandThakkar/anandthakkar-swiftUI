//
//  SettingsView.swift
//  Anand Thakkar
//
//  Created by Anand Thakkar on 27/09/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("useDynamicGlass") private var useDynamicGlass: Bool = true
    @AppStorage("showContact") private var showContact: Bool = true

    var body: some View {
        NavigationStack {
            List {
                Section("Appearance") {
                    Toggle("Use dynamic glass effects", isOn: $useDynamicGlass)
                    // Hook this into your own conditional styles if you want
                }
                Section("Portfolio") {
                    Toggle("Show contact section", isOn: $showContact)
                }
                Section("About") {
                    HStack {
                        Text("App")
                        Spacer()
                        Text("Anand Thakkar").foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0").foregroundStyle(.secondary)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Settings")
        }
    }
}
