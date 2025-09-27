//
//  BlogsView.swift
//  Anand Thakkar
//
//  Created by Anand Thakkar on 27/09/25.
//

import SwiftUI
import SafariServices

// An identifiable wrapper for your URL
private struct WebDestination: Identifiable {
    let id = UUID()
    let url: URL
}

struct BlogsView: View {
    @State private var webDest: WebDestination?   // drives the sheet

    var body: some View {
        NavigationStack {
            List {
                Section("Blog Posts 📝") {
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("From Tax to Tech - My Journey from Accounting to Development")
                                .font(.headline)

                            Text("A personal story of pivoting from a career in taxation and accounting to becoming a mobile and backend developer.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        Text("August 18, 2022")
                            .font(.footnote)
                            .foregroundStyle(.secondary)

                        // Open bottom sheet with in-app Safari
                        Button {
                            webDest = WebDestination(url: URL(string: "https://www.anandthakkar.com/blog/tax-to-tech")!)
                        } label: {
                            Text("Read more →")
                                .font(.callout.weight(.semibold))
                        }
                        .buttonStyle(.plain)
                        .foregroundStyle(.tint)
                    }
                    .padding(.vertical, 6)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Blogs")
        }
        // Use `.sheet(item:)` so the URL is guaranteed to exist when the sheet appears
        .sheet(item: $webDest) { dest in
            SafariSheet(url: dest.url)
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium, .large])
                .presentationCornerRadius(16)
        }
    }
}

// MARK: - In-app Safari
struct SafariSheet: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let vc = SFSafariViewController(url: url)
        vc.preferredControlTintColor = UIColor.tintColor
        vc.dismissButtonStyle = .done
        return vc
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) { }
}
