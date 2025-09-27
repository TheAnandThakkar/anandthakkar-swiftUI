//
//  ProjectsView.swift
//  Anand Thakkar
//
//  Created by Anand Thakkar on 27/09/25.
//

import SwiftUI

// MARK: - Model

struct Project: Identifiable {
    enum Icon {
        case system(String)
        case asset(String)
        case remote(URL)
    }

    let id = UUID()
    let title: String
    let subtitle: String?
    let blurb: String
    let linkTitle: String
    let linkURL: URL
    let icon: Icon
    let ribbon: String?            // ← NEW: optional ribbon text (e.g., "Featured")
}

// MARK: - View

struct ProjectsView: View {

    // Example data — replace URLs with your actual repos
    private let projects: [Project] = [
        // NEW: portfolio app with a ribbon
        Project(
            title: "Anand Thakkar\nPortfolio – SwiftUI",
            subtitle: "iOS App",
            blurb: "Personal portfolio app with a Settings-style grouped UI, tabs (Home, Certificates, Projects, Blogs, Settings), and optional Liquid Glass fallback.",
            linkTitle: "View source",
            linkURL: URL(string: "https://github.com/TheAnandThakkar/anandthakkar-swiftUI")!,
            icon: .system("swift"),
            ribbon: "Featured"
        ),
        Project(
            title: "Anand Thakkar\nPortfolio – NextJS",
            subtitle: "NextJS Website",
            blurb: "Build your portfolio in minutes — clone, customize, deploy. Free & open-source.",
            linkTitle: "View source",
            linkURL: URL(string: "https://github.com/TheAnandThakkar/anandthakkar-nextJS")!,
            icon: .system("wand.and.stars"),
            ribbon: nil
        ),
        Project(
            title: "Concerto Linter",
            subtitle: "GSoC 2025 Proposal",
            blurb: "A linter tool for the Concerto modeling language, designed to enhance code validation, catch errors early, and improve overall developer productivity.",
            linkTitle: "View on GitHub",
            linkURL: URL(string: "https://github.com/TheAnandThakkar/concerto-linter")!,
            icon: .system("chevron.left.forwardslash.chevron.right"),
            ribbon: nil
        ),
        Project(
            title: "EMI Calculation API (NestJS)",
            subtitle: nil,
            blurb: "A backend API service built with NestJS for calculating wage-based loan and salary EMIs, enabling accurate and efficient financial planning.",
            linkTitle: "View on GitHub",
            linkURL: URL(string: "https://github.com/TheAnandThakkar/emi_calculation_nestjs")!,
            icon: .system("server.rack"),
            ribbon: nil
        ),
        Project(
            title: "Todo (Task Management App)",
            subtitle: nil,
            blurb: "A lightweight task management application for creating, tracking, and organizing to-do items with a simple and efficient workflow.",
            linkTitle: "View on GitHub",
            linkURL: URL(string: "https://github.com/TheAnandThakkar/todo")!,
            icon: .system("checklist"),
            ribbon: nil
        )
    ]

    @ScaledMetric(relativeTo: .body) private var iconSide: CGFloat = 44

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(projects) { project in
                        ProjectRow(project: project, iconSide: iconSide)
                            .padding(.vertical, 2)
                    }
                } header: {
                    Text("Open-Source & Contributions 👨🏻‍💻")
                        .textCase(nil)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Projects")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Row

private struct ProjectRow: View {
    let project: Project
    let iconSide: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                IconTile(icon: project.icon)
                    .frame(width: iconSide, height: iconSide)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(.quaternary, lineWidth: 0.5)
                    )
                    .accessibilityHidden(true) // decorative

                VStack(alignment: .leading, spacing: 4) {
                    Text(project.title)
                        .font(.headline)

                    if let subtitle = project.subtitle {
                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Text(project.blurb)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            Link(project.linkTitle, destination: project.linkURL)
                .font(.callout.weight(.semibold))
                .foregroundStyle(.tint)
        }
        .padding(.vertical, 6)
        // Ribbon overlay (only when provided)
        .overlay(alignment: .topTrailing) {
            if let ribbon = project.ribbon {
                Ribbon(text: ribbon)
                    .padding(.top, -2)
                    .padding(.trailing, -2)
            }
        }
    }
}

// MARK: - Ribbon

private struct Ribbon: View {
    let text: String
    var body: some View {
        Text(text.uppercased())
            .font(.caption2.weight(.bold))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .foregroundStyle(.white)
            .background(
                Capsule(style: .continuous)
                    .fill(Color.accentColor)
            )
            .shadow(color: .black.opacity(0.12), radius: 3, y: 2)
            .accessibilityLabel(Text("\(text) project"))
    }
}

// MARK: - Icon tile

private struct IconTile: View {
    let icon: Project.Icon

    var body: some View {
        switch icon {
        case .system(let name):
            ZStack {
                Rectangle().fill(.clear)
                Image(systemName: name)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.secondary)
            }

        case .asset(let name):
            Image(name)
                .resizable()
                .scaledToFill()

        case .remote(let url):
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Rectangle().fill(.ultraThinMaterial)
                        ProgressView()
                    }
                case .success(let image):
                    image.resizable().scaledToFill()
                case .failure:
                    ZStack {
                        Rectangle().fill(.quaternary)
                        Image(systemName: "photo")
                            .imageScale(.medium)
                            .foregroundStyle(.secondary)
                    }
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ProjectsView()
}
