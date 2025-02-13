# ✨ Movies App With Clean Architecture ✨

This project demonstrates the implementation of 🎬 Movies App With Clean Architecture in a Flutter application. The goal is to provide a clear, scalable structure by separating concerns into distinct layers, improving maintainability, testability, and scalability.

## 📷 Screenshots

### 🏠 Home Screen
<div align="center">
  <img src="https://github.com/user-attachments/assets/6e2fd026-9ac3-4c35-87b1-4d9e05ca2ead" width="200" style="left: 30px;">
  <img src="https://github.com/user-attachments/assets/0e3dcf91-ef79-4c53-ba48-9c08d249248d" width="200">
</div>

### 🔍 Search
  <img src="https://github.com/user-attachments/assets/854c430b-3f5f-41f7-b1ae-ea12d0f4de9a" width="200">

### 👀 Movie Details on Long Press on Search Item
  <img src="https://github.com/user-attachments/assets/133370e5-77fd-496d-b05f-ef24303ec3ab" width="200">
  
### Movie details on long press on search item 
  <img src="https://github.com/user-attachments/assets/c787040d-edc4-46d4-8c88-670a4061f50c" width="200">


## Table of Contents

- [Introduction](#✨Introduction)
- [Project Structure](#project-structure)
- [Layers](#layers)
  - [Presentation Layer](#presentation-layer)
  - [Domain Layer](#domain-layer)
  - [Data Layer](#data-layer)
- [Getting Started](#🚀-Getting-Started)
- [Contributing](#contributing)
- [API-Configuration](#📂-API-Configuration)
- [State-Management](#State-Management)
- [License](#⚖️-License)

## ✨Introduction

**Clean Architecture** is a software design principle that organizes code into different layers, each with a single responsibility. This separation enhances codebase maintainability, improves testability, and enables scalability. This project adheres to Clean Architecture principles to structure a Flutter application effectively. It utilizes MoviesDB API for fetching movie data and employs BLoC for state management.



## 🌐 Project Structure


**Clean Architecture** is a software design principle that organizes code into different layers, each with a single responsibility. This separation enhances codebase maintainability, improves testability, and enables scalability. This project adheres to Clean Architecture principles to structure a Flutter application effectively.

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

## 📂 API Configuration

APIs Used

Get Popular Movies: GET /movie/popular

Get Top Rated Movies: GET /movie/top_rated

Get Recommended Movies: GET /movie/{movie_id}/recommendations

Search Movies: GET /search/movie?query={query}

Get Movie Details: GET /movie/{movie_id}

Screens Using Movies API

- Home Screen:

Displays a list of popular movies, top-rated movies, and recommended movies fetched from the API.

Implements pagination for popular and top-rated movies.

- Search Screen:

Allows users to search for movies using the API's search endpoint.

Implements pagination for search results.

- Movie Details Screen:

Shows detailed information about a selected movie, including synopsis and rating.

Fetches recommended movies for similar content suggestions.

## State Management

This project uses BLoC (Business Logic Component) and Cubit for state management, ensuring efficient handling of API responses, UI updates, and state transitions.

- Home Screen:

Uses HomeMoiveBloc to manage state for popular movies, top-rated movies, and recommendations.

Implemented pagination using BLoC for handling infinite scrolling.

- Search Screen:

Uses SearchCubit to handle search queries and manage state for search results.

Implemented pagination for efficient data fetching.

- Movie Details Screen:

Uses  MovieDetailsCubit Cubit to fetch and manage movie details and recommendations dynamically.


To install dependencies, run:

```bash
flutter pub get
```

## 🚀 Getting Started

Follow these steps to set up the project:

Ensure you have an .env file in the project root for easier setup. This file is added to the project directory to simplify API key management and avoid hardcoding sensitive information directly in the codebase. It only contains the Movie DB API key.

1. **Clone the repository:**

   ```bash
   git clone https://github.com/ZeyadShawki/Aurora-Movies-Assessment-Flutter.git
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the application:**

   ```bash
   flutter run
   ```

## 📚 Contributing

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


## ⚖️ License

This project is licensed under the MIT License. See the `LICENSE` file for details.
