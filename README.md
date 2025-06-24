# Flutter Dec

A Flutter chat application with command processing capabilities.

## Features

- Chat interface for sending and receiving messages
- Command processing system using the "/" prefix
- Issue tracking functionality
- Support for the "/q what was the last issue before this one" command to retrieve previous issues

## Project Structure

```
lib/
  ├── main.dart              # Application entry point
  ├── models/
  │   ├── conversation_model.dart  # Handles message history and command processing
  │   └── message.dart       # Message data model
  ├── screens/
  │   └── chat_screen.dart   # Main chat interface
  └── widgets/
      └── message_bubble.dart  # UI component for displaying messages
```

## Commands

The application supports the following commands:

- `/q what was the last issue before this one` - Retrieves the issue that was discussed before the current one
- `/dwqdqwd` - Test command that responds with a success message

## Getting Started

1. Ensure you have Flutter installed on your machine
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the application

## Testing

Run `flutter test` to execute the unit tests.
