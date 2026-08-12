# Smart Gift Finder (AI-Powered Mobile App)

> An AI-powered Flutter application built with Clean Architecture that helps users discover gifts for any occasion based on age, profession, budget, and recipient interests using **Gemini AI** and external shopping APIs.

## Project Overview

Smart Gift Finder is a graduation project mobile application that takes the stress out of choosing the perfect gift. Users answer a few questions about the recipient (age, profession, occasion, budget, interests) and the app uses **Google Gemini AI** to recommend personalized gift ideas. Each recommendation is backed by real, purchasable products fetched from external shopping APIs, so the user can view details, save favorites, and complete a full shopping flow — all in one place.

## Key Features

- **AI Gift Finder**: Personalized gift recommendations powered by Gemini AI based on recipient profile (age, profession, occasion, budget, interests).
- **Smart Search**: Quick product search across the catalog with seamless results.
- **Category Browsing**: Browse gifts by category with a dynamic budget range slider filter.
- **Product Details**: Rich product screens with image carousels, pricing, and descriptions.
- **Cart Management**: Full shopping cart flow with quantity management and add-to-cart feedback.
- **Wishlist / Favorites**: Persistent favorites stored per user across sessions.
- **Authentication**: Email/password sign-up, login, and password reset backed by Firebase Auth.
- **Onboarding Flow**: First-launch onboarding experience with local state persistence.
- **Responsive UI**: Clean, consistent theming with shared colors, text styles, and reusable widgets.

## Technologies Used

| Layer | Technology |
| --- | --- |
| UI Framework | Flutter & Dart |
| State Management | BLoC / Cubit (flutter_bloc) |
| Architecture | Clean Architecture (Data, Domain, Presentation) |
| Dependency Injection | Injectable + GetIt (service_locator) |
| Backend Services | Firebase Auth, Cloud Firestore, Firebase Storage |
| AI Engine | Google Gemini AI (google_generative_ai) |
| Networking | Dio & HTTP (DummyJSON API, Pexels API) |
| Local Storage | shared_preferences, flutter_secure_storage |
| Environment | flutter_dotenv |
| Media | cached_network_image, flutter_svg, carousel_slider, image_picker |

## Clean Architecture Folder Structure

```
lib/
├── core/                          # Shared cross-cutting concerns
│   ├── constants/                 # App assets, constants, onboarding content
│   ├── di/                        # service_locator, injectable modules
│   ├── network/                   # Dio client, API constants, result handling
│   ├── routes/                    # App routing (app_routes.dart, routes.dart)
│   ├── theme/                     # App colors, text styles, theme
│   ├── widgets/                   # Reusable widgets (buttons, text fields, cards)
│   ├── services/                  # Secure storage service
│   ├── storage_helper/            # Local storage helpers
│   ├── model/                     # Shared product entities & DTOs
│   ├── logger/                    # Logging utilities
│   └── ...                        # enums, extensions, validators, dialogs
├── feature/                       # Feature-first modules (each with clean layers)
│   ├── ai_finder/                 # Gemini AI gift recommendations
│   │   ├── data/                  #   - repositories, datasources, models
│   │   ├── domain/                #   - entities, usecases, repository contracts
│   │   └── presentation/          #   - cubit, screens, widgets
│   ├── auth/                      # Login, registration (Firebase Auth)
│   ├── onboarding/                # Onboarding flow (shared_preferences flag)
│   ├── cart/                      # Shopping cart management
│   ├── wishlist/                  # Favorites persistence
│   ├── product_details/           # Product details & image slider
│   ├── search/                    # Search feature
│   ├── home/                      # Home & category browsing
│   ├── app_section/               # App shell & bottom navigation
│   ├── account/                   # User account
│   ├── reset_password/            # Password reset flow
│   └── splash/                    # Splash screen
└── main.dart                      # App entry point
```

Each feature follows the same Clean Architecture pattern:

```
feature/<feature_name>/
├── data/
│   ├── models/          # JSON models (DTOs)
│   ├── datasources/     # Remote/local data sources
│   └── repositories/    # Concrete repository implementations
├── domain/
│   ├── entities/        # Business entities
│   ├── repositories/    # Abstract repository contracts
│   └── usecases/        # Business rules / use cases
└── presentation/
    ├── cubit/           # Cubit + State
    ├── view/
    │   ├── screens/     # UI screens
    │   └── widgets/     # Feature-specific widgets
    └── view_model/      # View models & states
```

## Environment Setup (.env)

The app loads sensitive keys from a `.env` file located in the project root (already declared as an asset in `pubspec.yaml`).

Create a `.env` file in the project root:

```bash
GEMINI_API_KEY=your_gemini_api_key_here
PEXELS_API_KEY=your_pexels_api_key_here
```

> **Important**: Never commit the real `.env` file. Keep your keys secret and add `.env` to `.gitignore`.

## Installation & Running Instructions

### Prerequisites

- Flutter SDK (stable channel, Dart `>=3.0.0`)
- Android Studio / Xcode / Edge (for web)
- A Firebase project configured with Auth, Firestore, and Storage (`firebase_options.dart`)

### Steps

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd Smart_Gift_Finder_ITI_Flutter_2026
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate the dependency injection code**

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Configure environment variables**

   Create the `.env` file (see [Environment Setup](#environment-setup-env)) and add your API keys.

5. **Set up Firebase**

   - Add your `google-services.json` (Android) and/or `GoogleService-Info.plist` (iOS).
   - Regenerate `lib/firebase_options.dart` for your platform if needed.

6. **Run static analysis**

   ```bash
   flutter analyze
   ```

7. **Run the app**

   ```bash
   flutter run -d edge
   ```

## Team Members & Task Distribution

| Member | Role | Responsibilities |
| --- | --- | --- |
| **Mahmoud** | Full-stack Integration & System Architecture | Full-stack Integration, App Routing, Search Feature, Web Compatibility & System Architecture |
| **Mariam** | Team Leader | Project Setup, Architecture Design, Core Configurations & Reviews |
| **Alaa** | Onboarding & Authentication | Onboarding Flow, Authentication & UI Setup |
| **Aya** | Shopping Flow | Cart Management, Product Details & Shopping Flow |
| **Tasneem** | AI & Favorites | Wishlist / Favorites Persistence & AI Finder Integration |

## License

This project was developed as a graduation project and is intended for educational purposes.
