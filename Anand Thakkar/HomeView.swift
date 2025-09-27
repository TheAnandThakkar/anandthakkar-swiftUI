//
//  HomeView.swift
//  Anand Thakkar
//
//  Created by Anand Thakkar on 27/09/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.openURL) private var openURL
    private let calendar = Calendar(identifier: .gregorian)

    // Start date of experience (safe init)
    private let experienceStart: Date = {
        var comps = DateComponents(year: 2022, month: 5, day: 16)
        comps.timeZone = TimeZone(secondsFromGMT: 0)
        return Calendar(identifier: .gregorian).date(from: comps) ?? Date()
    }()

    // Localized: "3 years, 4 months" (auto pluralization)
    private var experienceLong: String {
        let now = Date()
        let comps = calendar.dateComponents([.year, .month], from: experienceStart, to: now)
        let y = max(0, comps.year ?? 0)
        let m = max(0, comps.month ?? 0)

        // Build a duration & format it (localized)
        var dc = DateComponents()
        dc.year = y
        dc.month = m

        let f = DateComponentsFormatter()
        f.allowedUnits = [.year, .month]
        f.unitsStyle = .full
        f.maximumUnitCount = 2
        return f.string(from: dc) ?? "\(y) year\(y == 1 ? "" : "s"), \(m) month\(m == 1 ? "" : "s")"
    }

    // Short chip for the “Joining Date” line, e.g. "3 yr 4 mo"
    private var experienceShort: String {
        let now = Date()
        let comps = calendar.dateComponents([.year, .month], from: experienceStart, to: now)
        let y = max(0, comps.year ?? 0)
        let m = max(0, comps.month ?? 0)
        switch (y, m) {
        case (0, let m): return "\(m) mo"
        case (let y, 0): return "\(y) yr"
        default:         return "\(y) yr \(m) mo"
        }
    }

    // Dynamic Type–aware avatar size
    @ScaledMetric(relativeTo: .title) private var avatarSide: CGFloat = 120
    private let avatarCorner: CGFloat = 22

    var body: some View {
        NavigationStack {
            List {
                // Profile + About
                Section {
                    VStack(alignment: .leading, spacing: 16) {

                        // Photo
                        Image("profile")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: avatarSide, height: avatarSide)
                            .clipShape(RoundedRectangle(cornerRadius: avatarCorner, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: avatarCorner, style: .continuous)
                                    .stroke(.quaternary, lineWidth: 0.5)
                            )
                            .accessibilityLabel("Portrait of Anand Thakkar")

                        // Name
                        Text("Anand Thakkar")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .lineLimit(2)
                            .minimumScaleFactor(0.9)

                        // Subtitle / tagline
                        Text("Backend Engineer • AWS Certified Cloud Practitioner • Fintech/SaaS")
                            .font(.subheadline)
                            .foregroundStyle(.primary)

                        // About paragraph (duplicate .foregroundStyle removed)
                        Text("""
                        Backend developer with \(experienceLong) of experience in fintech/SaaS. Skilled in Java, Spring Boot, AWS, and building scalable APIs with a focus on performance and cost optimization. Strong cross-functional collaborator bridging engineering and product.
                        """)
                        .foregroundStyle(.secondary)
                    }
                }

                // Work experience
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(alignment: .top, spacing: 12) {
                            Image("agileLogo")
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
                                .frame(width: 44, height: 44)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .stroke(.quaternary, lineWidth: 0.5)
                                )
                                .accessibilityHidden(true) // decorative

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Agile Infoways")
                                    .font(.headline)

                                Text("Software Developer")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)

                                Text("Contributed to full-stack application development, optimized backend APIs, and collaborated with cross-functional teams to deliver scalable software solutions.")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }

                        Text("Joining Date: May 2022 – Present • \(experienceShort)")
                            .font(.footnote)
                            .foregroundStyle(.secondary)

                        Link("Visit website", destination: URL(string: "https://www.agileinfoways.com")!)
                            .font(.callout.weight(.semibold))
                            .foregroundStyle(.tint)
                    }
                    .padding(.vertical, 6)
                } header: {
                    Text("Work Experience 💼")
                        .textCase(nil)
                }
            }
            .listStyle(.insetGrouped) // <— apply to List
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
