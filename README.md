📝 To-Do List App

This is a simple To-Do List app built with Flutter. The app allows users to add, view, and mark tasks as completed. It follows clean architecture principles and uses various state-of-the-art Flutter packages, including GetX for state management and get_it for dependency injection.
🚀 Features

    Add new tasks with a title.
    View a list of all tasks.
    Mark tasks as completed or incomplete.
    Persistent task storage using Shared Preferences.
    Clean architecture following SOLID principles.
    Dependency injection using get_it.
    State management using GetX.
    Unit tests for core functionalities.

🛠️ Technologies & Architecture
Architecture:

The project follows clean architecture principles, breaking the app into the following layers:

    Data Layer:
        Handles task storage and retrieval.
        Contains models and repositories.
        Task data is stored locally using Shared Preferences.

    Domain Layer:
        Contains business logic and use cases.
        Implements use cases like adding, retrieving, and completing tasks.

    Presentation Layer:
        The UI layer, responsible for rendering task lists, forms, and other elements.
        Uses GetX for managing the state of the app.

Packages:

    Flutter: The core framework.
    GetX: For state management and routing.
    get_it: For dependency injection.
    Shared Preferences: For local task persistence.
    Json Serializable: For easy JSON encoding/decoding.
    Mockito: For testing and mocking dependencies.

⚙️ Setup & Installation

    Clone the repository:

    bash

git clone https://github.com/yourusername/to_do.git
cd to_do

Install dependencies:

bash

flutter pub get

Run the app:

bash

flutter run

Run tests: To run the unit tests, use the command:

bash

    flutter test

🧪 Testing

This project includes unit tests for the key functionalities, such as adding tasks, retrieving tasks, and marking tasks as completed. Tests are located in the test/ directory.
Run tests:

bash

flutter test

🧱 Core Functionalities

    Add Task: Adds a new task with a title. Tasks are stored using Shared Preferences for persistence.
    Retrieve Tasks: Fetches the list of tasks (completed and uncompleted) from local storage.
    Mark Task as Completed: Marks a task as completed by toggling the isCompleted flag.

🔨 Dependency Injection

The project uses get_it for dependency injection. The injection.dart file contains the necessary configurations for injecting repositories and controllers throughout the app.

dart
final getIt = GetIt.instance;

void setup() {

  getIt.registerLazySingleton<TaskRepository>(  () => TaskRepositoryImpl(sharedPreferences: getIt()),  );
  
  getIt.registerLazySingleton(() => TaskController(getIt()));
}

