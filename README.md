Expense Tracker Lite

Overview
Expense Tracker Lite is a Flutter mobile application designed to help users track their expenses easily and efficiently. The app supports multiple currencies with real-time currency conversion and persistent local storage.

Architecture and Structure
Clean Architecture principles applied with separation of concerns:

Data Layer: API services, repositories, local SQLite database helper.

Domain Layer: Business logic (e.g., currency conversion).

Presentation Layer: UI screens, widgets, and Cubits (BLoC pattern).

Folder structure:

css
Copy
Edit
lib/
features/
add_expense/
dashboard/
core/
networking/
helpers/
main.dart
State Management Approach
Uses Cubit from the flutter_bloc package for managing UI state reactively.

Cubits handle business logic and emit states to update the UI.

Mocktail is used for unit and widget testing.

API Integration
Currency conversion handled via a REST API.

API calls are made through a dedicated ApiService class using the Dio HTTP client.

Repositories abstract API and data sources for cleaner logic.

Dependency injection is managed with GetIt.

Pagination Strategy
Pagination is implemented locally on the app side for simplicity.

The dashboard screen loads a limited number of expenses at once and has a "Load More" button.

On tapping "Load More," the app fetches the next batch from the local database.

Future versions may include API pagination.

UI Screenshots

Dashboard showing expense list with Load More button


Add Expense screen with form validation

(Add your actual screenshots inside the screenshots/ folder)

Trade-offs and Assumptions
Currency rates are fetched on demand and cached minimally for simplicity.

Local SQLite database used for persistence instead of a cloud backend.

Pagination is local, so large datasets might affect performance.

Error handling is basic and can be improved.

No user authentication implemented yet.

How to Run the Project
Clone the repo:

bash
Copy
Edit
git clone https://github.com/yourusername/expense-tracker-lite.git
cd expense-tracker-lite
Install dependencies:

bash
Copy
Edit
flutter pub get
Run on device or emulator:

bash
Copy
Edit
flutter run
To run tests:

bash
Copy
Edit
flutter test
Known Bugs or Unimplemented Features
No offline synchronization for currency rates.

No user profiles or multi-user support.

Basic UI design — needs polish and accessibility improvements.

Error states and network failure handling are minimal.
