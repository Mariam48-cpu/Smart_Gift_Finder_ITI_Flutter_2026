# Agent Instructions & Guidelines - Smart Gift Finder Project

## Project Context & Resources
- **Flutter App Root**: `./`
- **Figma Screens Directory**: `../Figma_Pics/`
- **PDF Requirement Specs**: `../final_project_pdf/`
- **Architecture Standard**: Clean Architecture (Data, Domain, Presentation with BLoC) + GetIt/Injectable for Dependency Injection.

## Strict Git Rules
1. NEVER commit or push code directly to `master` or `dev` branches.
2. ALWAYS verify the current working branch is a feature branch (e.g., `feature/task-4-onboarding`).
3. Push changes ONLY to origin's feature branch and prepare Pull Request details for team review.

## Code Quality & Skills Integration
1. Apply Dart Clean Architecture patterns: strictly separate Data, Domain, and Presentation layers.
2. Ensure UI components handle responsive sizing and prevent pixel overflow issues.
3. Keep logic inside Cubit / BLoC classes, never in UI Widgets.
4. Extract colors, text styles, and assets paths to `core/theme/` and `core/constants/`.

## Assigned Tasks
- **Task 4**: Build Onboarding Feature with local flag state (`shared_preferences`).
- **Task 10**: Build Category Products view with dynamic Budget Range Slider filter and double precision parsing.