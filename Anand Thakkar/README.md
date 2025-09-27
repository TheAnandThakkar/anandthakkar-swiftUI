# Anand Thakkar — iOS Portfolio (SwiftUI, mock data)

A minimal SwiftUI **learning project** that renders a personal portfolio with a bottom tab bar:
**Home · Certificates · Projects · Blogs · Settings**.  
This repo currently uses **static mock data** and **does not include an app icon**. It’s intended as a simple starting point for learners — contributions are welcome! 🙌

---

## Project Structure

```text
Anand Thakkar/
└─ Anand Thakkar/
   ├─ Anand_ThakkarApp.swift
   ├─ Assets.xcassets/
   ├─ BlogsView.swift
   ├─ CertificatesView.swift
   ├─ ContentView.swift
   ├─ HomeView.swift
   ├─ ProjectsView.swift
   ├─ SettingsView.swift
   └─ Products/
README.md
LICENCE
```

- **Anand_ThakkarApp.swift** — `@main` entry that launches the initial view stack.
- **ContentView.swift** — Xcode’s starter view (kept for simplicity; you can remove or repurpose).
- **HomeView.swift** — Profile header (image, name, tagline), about text, work experience.
- **CertificatesView.swift** — Static list of sample certificates.
- **ProjectsView.swift** — Static list of sample projects (tags + blurbs).
- **BlogsView.swift** — Static list of sample posts/links.
- **SettingsView.swift** — Basic toggles, about section (no persistence beyond `@AppStorage`).
- **Assets.xcassets/** — Add images here (e.g., `profile`, `agileLogo`). Currently **no app icon**.
- **Products/** — Xcode build products (derived).

> Note: This is a **mock app**; data is hard-coded inside the views. There’s no networking, persistence, or app icon yet.

---

## Requirements

- **Xcode 15+** (or newer).  
- **iOS Deployment Target:** 17.0 (the code runs on iOS 17+).  
- Optional: If you later add **Liquid Glass** effects, you’ll need an iOS 26 simulator/device to see them; otherwise the app will render with standard materials.

---

## Getting Started

1. Open the project in Xcode.
2. Add a **square headshot** to **Assets.xcassets** as `profile` (2x: 240×240, 3x: 360×360).
3. (Optional) Add `agileLogo` in **Assets.xcassets** for Work Experience.
4. Select any iOS simulator **(iOS 17+)** and **Run**.

---

## Roadmap / Ideas (good first issues)

- [ ] Replace mock data with JSON files in the repo (loaded via `Bundle`).
- [ ] Add a simple **Projects detail** screen and navigation.
- [ ] Create an **App Icon** set in `Assets.xcassets`.
- [ ] Add **Unit/UI tests** for key views.
- [ ] Add **CI** (Xcode Cloud or GitHub Actions) to build on PRs.
- [ ] Optional: Introduce **Liquid Glass** (iOS 26+) with graceful fallbacks.

---

## Contributing

This is a community-friendly learning repo. **Fork, branch, and open a PR!**  
Guidelines:
- Keep PRs small and focused.
- Prefer clean, readable SwiftUI.
- Include a brief description and screenshots/GIFs if the change affects UI.
- If adding dependencies or changing the deployment target, start a discussion first.

> New to open source? Open an issue labeled **good first issue** and we’ll help you get started.

---

## License

This project is licensed under the **MIT License**. See **[LICENSE](LICENSE)** for details.

---

## Acknowledgements

- Built with **SwiftUI**.
- Starter layout inspired by the native **Settings** grouped style.

