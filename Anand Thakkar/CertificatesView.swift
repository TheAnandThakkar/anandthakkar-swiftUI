//
//  CertificatesView.swift
//  Anand Thakkar
//
//  Created by Anand Thakkar on 27/09/25.
//

import SwiftUI

// MARK: - Model

struct Certificate: Identifiable {
    enum Logo {
        case asset(String)
        case remote(URL)        
    }

    let id = UUID()
    let title: String
    let issuer: String
    let blurb: String
    let issueDate: String?
    let linkTitle: String
    let linkURL: URL
    let logo: Logo
}

// MARK: - View

struct CertificatesView: View {
    // Example data — swap logo sources to .remote(URL) if you prefer online images.
    private let certificates: [Certificate] = [
        Certificate(
            title: "AWS Certified Cloud Practitioner (CLF-C02)",
            issuer: "Amazon Web Services",
            blurb: "Credential that validates foundational knowledge of AWS Cloud concepts, services, security, pricing, and support. Demonstrates the ability to effectively communicate cloud value to both technical and non-technical stakeholders.",
            issueDate: "August, 2024",
            linkTitle: "View on Credly",
            linkURL: URL(string: "https://www.credly.com/badges/037bcd56-d0fe-41d2-934f-3c3077832fcb/public_url")!, // replace with your actual badge link
            logo: .asset("aws-certified-cloud-practitioner.png") // or .remote(URL(string:"https://…/aws-ccp-badge.png")!)
        ),
        Certificate(
            title: "Google Developer Badges",
            issuer: "Google Developers",
            blurb: "Recognizes expertise and contributions in building applications using Google technologies. Validates proficiency in Google APIs, web and mobile development, and best practices for scalable, performant solutions.",
            issueDate: nil,
            linkTitle: "View on Google Developers",
            linkURL: URL(string: "https://g.dev/TheAnandThakkar")!,
            logo: .asset("google-dev.png") // or .remote(URL(string:"https://…/google-dev-badges.png")!)
        )
    ]

    @ScaledMetric(relativeTo: .body) private var logoSide: CGFloat = 44

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(certificates) { cert in
                        CertificateRow(cert: cert, logoSide: logoSide)
                            .padding(.vertical, 2)
                    }
                } header: {
                    Text("Awards & Certifications 🏆")
                        .textCase(nil)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Certificates")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Row

private struct CertificateRow: View {
    let cert: Certificate
    let logoSide: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                LogoView(logo: cert.logo)
                    .frame(width: logoSide, height: logoSide)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(.quaternary, lineWidth: 0.5)
                    )
                    .accessibilityHidden(true) // decorative logo

                VStack(alignment: .leading, spacing: 4) {
                    Text(cert.title)
                        .font(.headline)

                    Text(cert.issuer)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text(cert.blurb)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            if let when = cert.issueDate {
                Text("Issue date: \(when)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            // Text-style link for consistency with your Home view
            Link(cert.linkTitle, destination: cert.linkURL)
                .font(.callout.weight(.semibold))
                .foregroundStyle(.tint)
        }
        .padding(.vertical, 6)
    }
}

// MARK: - Logo loader

private struct LogoView: View {
    let logo: Certificate.Logo

    var body: some View {
        switch logo {
        case .asset(let name):
            Image(name)
                .resizable()
                .scaledToFill()

        case .remote(let url):
            // Async remote logo (PNG/JPEG recommended; SVGs won’t render)
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
    CertificatesView()
}
