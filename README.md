# Flutter Clean Architecture Example

This project demonstrates the implementation of **Movies App With Clean Architecture** in a Flutter application. The goal is to provide a clear, scalable structure by separating concerns into distinct layers, improving maintainability, testability, and scalability.

## Table of Contents

- [Introduction](#introduction)
- [Project Structure](#project-structure)
- [Layers](#layers)
  - [Presentation Layer](#presentation-layer)
  - [Domain Layer](#domain-layer)
  - [Data Layer](#data-layer)
- [Dependencies](#dependencies)
- [Getting Started](#getting-started)
- [Contributing](#contributing)
- [License](#license)

## Introduction

**Clean Architecture** is a software design principle that organizes code into different layers, each with a single responsibility. This separation enhances codebase maintainability, improves testability, and enables scalability. This project adheres to Clean Architecture principles to structure a Flutter application effectively.

## Project Structure

The project is divided into three primary layers:

```
lib/
├── core/
│   ├── app-preferances/
│   ├── app-router/
│   └── asset_manger/
│   └── helpers/
│   └── network/
│   └── service_loacater/
│   └── theme/
│   └── utils/
├── movies/
├──── data/
│    └── remote_data_source/
│    └── models/
│    └── repostery/
├──── domain/
│    └── entities/
│    └── repositories/
│    └── usecases/
└──── presentation/
     └── screens/
     └── widgets/
     └── bloc/
```

## Layers

### Presentation Layer

The **Presentation Layer** is responsible for UI components and user interactions. It communicates with the **Domain Layer** to fetch and display data.

- **Pages**: Contains the screens of the application.
- **Widgets**: Reusable UI components.
- **Bloc**: Implements the BLoC (Business Logic Component) pattern for state management.

### Domain Layer

The **Domain Layer** contains the core business logic and use cases of the application.

- **Entities**: Defines core business objects.
- **Repositories**: Abstract classes defining data access contracts.
- **Use Cases**: Contains application-specific business logic.

### Data Layer

The **Data Layer** is responsible for retrieving and storing data. It implements the repository contracts from the **Domain Layer** and interacts with external sources.

- **Datasources**: Defines the contract for data sources (e.g., APIs, local databases).
- **Models**: Represents data objects for serialization/deserialization.
- **Repositories**: Implements repository interfaces from the **Domain Layer**.

## Dependencies

This project uses the following dependencies:

- **flutter_bloc**: State management using the BLoC pattern.
- **dio**: HTTP client for API requests.
- **get_it**: Dependency injection.
- **shared_preferences**: Local storage.

To install dependencies, run:

```bash
flutter pub get
```

## Getting Started

Follow these steps to set up the project:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/Aurora-Movies-Assessment.git
   ```

2. **Navigate to the project directory:**

   ```bash
   cd flutter-clean-architecture
   ```

3. **Install dependencies:**

   ```bash
   flutter pub get
   ```

4. **Run the application:**

   ```bash
   flutter run
   ```

## Contributing

Contributions are welcome! Follow these steps to contribute:

1. **Fork the repository.**
2. **Create a new branch:**
   ```bash
   git checkout -b feature/YourFeatureName
   ```
3. **Commit your changes:**
   ```bash
   git commit -m 'Add feature: YourFeatureName'
   ```
4. **Push to the branch:**
   ```bash
   git push origin feature/YourFeatureName
   ```
5. **Open a pull request.**

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.


