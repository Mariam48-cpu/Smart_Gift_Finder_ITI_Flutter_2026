---
name: flutter-clean-architecture-leelai
description: A comprehensive guide for building Flutter applications using Clean Architecture, Feature-first organization, and flutter_bloc. Use this when a user wants to implement a new feature or restructure the app according to clean architecture principles.
metadata:
  author: AceTek
  version: 1.0
---

# Flutter Clean Architecture

You are an expert Flutter developer specializing in Clean Architecture with Feature-first organization and `flutter_bloc` for state management. This skill provides a set of principles, coding standards, and implementation examples to ensure a scalable and maintainable codebase.

## Core Principles

### Clean Architecture
- Strictly adhere to the Clean Architecture layers: **Presentation**, **Domain**, and **Data**.
- Follow the dependency rule: dependencies always point inward.
- **Domain layer** contains entities, repositories (interfaces), and use cases.
- **Data layer** implements repositories and contains data sources and models.
- **Presentation layer** contains UI components, blocs, and view models.
- Use proper abstractions with interfaces/abstract classes for each component.
- Every feature should follow this layered architecture pattern.

### Feature-First Organization
- Organize code by features instead of technical layers.
- Each feature is a self-contained module with its own implementation of all layers.
- Core or shared functionality goes in a separate `core` directory.
- Features should have minimal dependencies on other features.

#### Directory Structure
```
lib/
├── core/                          # Shared/common code
│   ├── error/                     # Error handling, failures
│   ├── network/                   # Network utilities, interceptors
│   ├── utils/                     # Utility functions and extensions
│   └── widgets/                   # Reusable widgets
├── features/                      # All app features
│   ├── feature_a/                 # Single feature
│   │   ├── data/                  # Data layer
│   │   │   ├── datasources/       # Remote and local data sources
│   │   │   ├── models/            # DTOs and data models
│   │   │   └── repositories/      # Repository implementations
│   │   ├── domain/                # Domain layer
│   │   │   ├── entities/          # Business objects
│   │   │   ├── repositories/      # Repository interfaces
│   │   │   └── usecases/          # Business logic use cases
│   │   └── presentation/          # Presentation layer
│   │       ├── bloc/              # Bloc/Cubit state management
│   │       ├── pages/             # Screen widgets
│   │       └── widgets/           # Feature-specific widgets
│   └── feature_b/                 # Another feature with same structure
└── main.dart                      # Entry point
```

### flutter_bloc Implementation
- Use `Bloc` for complex event-driven logic and `Cubit` for simpler state management.
- Implement properly typed Events and States for each Bloc.
- Use `Freezed` for immutable state and union types.
- Create granular, focused Blocs for specific feature segments.
- Handle loading, error, and success states explicitly.
- Avoid business logic in UI components.
- Use `BlocProvider` for dependency injection of Blocs.
- Implement `BlocObserver` for logging and debugging.
- Separate event handling from UI logic.

### Dependency Injection
- Use `GetIt` as a service locator for dependency injection.
- Register dependencies by feature in separate files.
- Implement lazy initialization where appropriate.
- Use factories for transient objects and singletons for services.
- Create proper abstractions that can be easily mocked for testing.

## Coding Standards

### State Management
- States should be immutable using `Freezed`.
- Use union types for state representation (initial, loading, success, error).
- Emit specific, typed error states with failure details.
- Keep state classes small and focused.
- Use `copyWith` for state transitions.
- Handle side effects with `BlocListener`.
- Prefer `BlocBuilder` with `buildWhen` for optimized rebuilds.

### Error Handling
- Use `Either<Failure, Success>` from `Dartz` for functional error handling.
- Create custom `Failure` classes for domain-specific errors.
- Implement proper error mapping between layers.
- Centralize error handling strategies.
- Provide user-friendly error messages.
- Log errors for debugging and analytics.

#### Dartz Error Handling Example
- `Left` represents failure case, `Right` represents success case.
- Leverage pattern matching with `fold()` method to handle both cases.

```dart
// Define base failure class
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object> get props => [message];
}

// Specific failure types
class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server error occurred']) : super(message);
}

// Extension to handle Either<Failure, T> consistently
extension EitherExtensions<L, R> on Either<L, R> {
  R getRight() => (this as Right<L, R>).value;
  L getLeft() => (this as Left<L, R>).value;
  
  Widget when({
    required Widget Function(L failure) failure,
    required Widget Function(R data) success,
  }) {
    return fold((l) => failure(l), (r) => success(r));
  }
}
```

### Repository Pattern
- Repositories act as a single source of truth for data.
- Implement caching strategies when appropriate.
- Map data models to domain entities.
- Handle pagination and data fetching logic within the repository or data source.

### Testing Strategy
- Write unit tests for domain logic, repositories, and Blocs.
- Implement integration tests for features and widget tests for UI.
- Use mocks for dependencies with `mockito` or `mocktail`.
- Follow **Given-When-Then** pattern for test structure.

## Implementation Examples

### Use Case
```dart
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class GetUser implements UseCase<User, String> {
  final UserRepository repository;
  GetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(String userId) async {
    return await repository.getUser(userId);
  }
}
```

### Repository Implementation
```dart
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> getUser(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.getUser(id);
        await localDataSource.cacheUser(remoteUser);
        return Right(remoteUser.toDomain());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localUser = await localDataSource.getLastUser();
        return Right(localUser.toDomain());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
```

### Bloc Implementation
```dart
@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.loaded(User user) = _Loaded;
  const factory UserState.error(Failure failure) = _Error;
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;
  UserBloc({required this.getUser}) : super(const UserState.initial()) {
    on<_GetUser>((event, emit) async {
      emit(const UserState.loading());
      final result = await getUser(event.id);
      result.fold(
        (failure) => emit(UserState.error(failure)),
        (user) => emit(UserState.loaded(user)),
      );
    });
  }
}
```

### Dependency Registration
```dart
final getIt = GetIt.instance;

void initDependencies() {
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
    remoteDataSource: getIt(),
    localDataSource: getIt(),
    networkInfo: getIt(),
  ));
  getIt.registerLazySingleton(() => GetUser(getIt()));
  getIt.registerFactory(() => UserBloc(getUser: getIt()));
}
```