# Core Models

A pure Dart library containing domain entities, value objects, and data transfer
objects (DTOs). This package forms the core of the domain layer, following Onion
Architecture principles—remaining entirely agnostic of UI, infrastructure, or
specific application logic.

## Features

- **Domain Entities**: Pure representations of domain concepts like `User`,
  `Goal`, `Chat`, and `Message`.
- **Value Objects**: Self-validating types such as `EmailAddress` and `Password`
  using the `formz` pattern.
- **Architectural Abstractions**: Standardized structures for authentication (
  Login/Register responses) and data operations.
- **Type Safety & Equality**: Heavy use of `equatable` for value-based equality
  and `json_annotation` for serialized DTOs.
- **Zero Dependencies on Outer Layers**: No references to Flutter, databases, or
  network clients.

## Getting started

Add this package as a dependency in your `pubspec.yaml`:

```yaml
dependencies:
  models:
    path: path/to/core/models
```

### Code Generation

Some models use `json_serializable`. Generate the necessary boilerplate using:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Usage

### Entities

Entities represent objects with a distinct identity.

```dart
import 'package:models/models.dart';

const goal = Goal(
  id: '1',
  title: 'Learn Onion Architecture',
  content: 'Understand the core layer principles.',
  userId: 'user_123',
);
```

### Value Objects

Value objects encapsulate validation logic and are immutable.

```dart
import 'package:models/models.dart';

final email = EmailAddress.dirty('test@example.com');
if (email.isValid) {
  print('Email is valid');
} else {
  print('Error: ${email.error}');
}
```

## Additional information

### Project Structure

- `lib/src/goal/`: Goal-related entities.
- `lib/src/enums/`: Domain-specific enumerations.
- `lib/src/abstract/`: Interface definitions and response abstractions.
- `lib/src/exceptions/`: Domain-specific exceptions.

### Contribution

When adding new models:

1. Ensure they remain agnostic of outer layers.
2. Use `equatable` for data-heavy classes.
3. Run `build_runner` if adding `@JsonSerializable` annotations.
