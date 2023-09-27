# Flutter Clean Architecture Application 🤠️

![Flutter Version](https://img.shields.io/badge/Flutter-3.13.5-blue)
![Dart Version](https://img.shields.io/badge/Dart-3.1.2-green)
![Android Studio Version](https://img.shields.io/badge/Android-2022.3-red)

This is a Flutter project that demonstrates the use of Clean Architecture for building robust and maintainable mobile applications. Clean Architecture promotes separation of concerns and modularity, making it easier to develop, test, and maintain your Flutter app.

## Table of Contents

- [Introduction](#introduction)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Features](#features)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Introduction

🚀️ This is a project for designers and artists where they upload their artwork to the app and set a price for that artwork, also in the app we provide a chat feature whenever people want to chat with each other

## Prerequisites

- 🐦️ Flutter Sdk
- 🦒️ Android Studio

## Getting Started

How to get started project 🐳️

```bash
# Clone the repository:
git clone https://github.com/Vanhoai/wflow.git

# Navigate to the project directory:
cd wflow

# Run project
flutter run
```

## Project structure

```bash
lib
|-- application
|   |-- application.dart
|   |-- injection.dart
|-- common
|   |-- app
|   |   |-- bloc.dart
|   |   |-- state.dart
|   |   |-- event.dart
|   |-- ... other common bloc
|-- configuration
|   |-- configuration.dart
|   |-- constant_config.dart
|   |-- env_config.dart
|-- library
|   |-- firebase
|   |   |-- firebase.dart
|   |-- ... other library
|   |-- library.dart
|-- modules
|   |-- auth
|   |   |-- datasource
|   |   |   |-- models
|   |   |   |   |-- request_model.dart
|   |   |   |   |-- response_model.dart
|   |   |   |-- auth_repository.dart
|   |   |   |-- auth_service.dart
|   |   |-- domain
|   |   |   |-- auth_entity
|   |   |   |   |-- auth_entity.dart
|   |   |   |   |-- auth_entity.g.dart
|   |   |   |-- auth_repository.dart
|   |   |   |-- auth_usecase.dart
|   |   |-- presentation
|   |   |   |-- widgets
|   |   |   |   |-- ... common widget for auth screen
|   |   |   |-- signin
|   |   |   |   |-- widget
|   |   |   |   |-- ... widget special for sign in screen
|   |   |   |   |-- bloc
|   |   |   |   |   |-- bloc.dart
|   |   |   |   |   |-- state.dart
|   |   |   |   |   |-- event.dart
|   |   |   |   |-- sign_in.dart
|   |   |   |-- ... other screen in auth
|   |-- main
|   |   |-- datasource
|   |   |   |-- user
|   |   |   |   |-- models
|   |   |   |   |   |-- request_model.dart
|   |   |   |   |   |-- response_model.dart
|   |   |   |   |-- user_repository.dart
|   |   |   |   |-- user_service.dart
|   |   |   |-- ... other data source
|   |   |-- domain
|   |   |   |-- user
|   |   |   |   |-- user_entity
|   |   |   |   |   |-- user_entity.dart
|   |   |   |   |   |-- user_entity.g.dart
|   |   |   |   |-- user_repository.dart
|   |   |   |   |-- user_usecase.dart
|   |   |   |-- ... other domain
|   |   |-- presentation
|   |   |   |-- home
|   |   |   |   |-- home
|   |   |   |   |   |-- bloc
|   |   |   |   |   |   |-- bloc.dart
|   |   |   |   |   |   |-- state.dart
|   |   |   |   |   |   |-- event.dart
|   |   |   |   |   |-- home.dart
|   |   |   |-- ... other screen in bottom
```
