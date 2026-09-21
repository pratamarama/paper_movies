# paper_movies

<img width="300" height="652" alt="Simulator Screenshot - iPhone 16 Pro - 2026-09-21 at 14 58 56" src="https://github.com/user-attachments/assets/19b5407b-852a-4e42-90a8-fbcfb72dcda4" style="margin: 20px;"/>

<img width="453" height="652" alt="Simulator Screenshot - iPad (A16) - 2026-09-21 at 14 58 07" src="https://github.com/user-attachments/assets/c6e7f076-8f9c-44a8-98fc-339b7164dedb" style="margin: 20px;"/>


An app for find movies by category and searching by title.

The app displays a clean list of movie results with showing adaptive list view for mobile and tablet devices.

The app will only show the first 20 results for each category and search. 

The app not implement pagination yet. The app intentionally limits results to the first 20 items for each category and search to keep the experience lightweight and consistent with the current scope. It also keeps the flow simple by avoiding pagination for now, which reduces complexity while still delivering a clear user experience.

## Implementation and design decisions

- This project follows Clean Architecture and the MVVM pattern to separate responsibilities and keep the app easier to maintain as it grows.
- The project follows a layered structure to keep business logic separate from UI code.
- The data layer is responsible for fetching and mapping movie data from the API, while the domain layer defines the use cases and model contracts that the rest of the app depends on.
- The presentation layer is kept lean and reacts to state changes through BLoC, which makes the UI predictable and easier to test.
- Dependency injection is centralized with get_it so services, repositories, and BLoC dependencies can be configured in one place. Using freezed and json_serializable helps reduce boilerplate, gives stronger type safety, and keeps generated models consistent as the app grows.

## Architecture overview

```
+---------------------+
| Presentation Layer  |
|  UI + Widgets + BLoC|
+----------+----------+
           |
           v
+---------------------+
| Domain Layer         |
| Use cases / models   |
+----------+----------+
           |
           v
+---------------------+
| Data Layer          |
| API + repositories  |
+---------------------+
```

### Development workflow
- Flutter SDK.
- Dart analysis and code generation.
- Makefile-based project commands.
- CI-friendly structure for extension and testing.

## Getting Started

This project is a Flutter application. To run the app, you need to have Flutter installed on your machine. You can follow the official Flutter installation guide [here](https://flutter.dev/docs/get-started/install).

This project was created with Flutter version 3.41.9, Channel stable.

How to run the app:
- Clone the repository.
- Run `flutter pub get` to install dependencies.
- Run `make generate` to generate the freezed and json_serializable code.
- Please use --dart-define to store your API key in the command line when running the app. For example:
```bash
flutter run --dart-define=API_KEY=your_api_key_here
```
