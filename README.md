# 🎵 Hulkify - Music Streaming App

Hulkify is a powerful, feature-rich music streaming app built using Flutter and Dart, with Firebase Authentication for secure user login and registration. Inspired by the strength and resilience of the Hulk, this app aims to provide a smooth, enjoyable, and immersive experience for music lovers on Android.

## 📱 Features

- **User Authentication**: Secure sign-up and login with Firebase Authentication.
- **Music Streaming**: Browse, play, and enjoy a wide range of music.
- **Playlists and Favorites**: Create and manage playlists, and save favorite songs.
- **Personalized Recommendations**: Discover new music based on your listening habits.
- **Search**: Quickly find artists, albums, and tracks with the search feature.
- **Responsive UI**: A smooth, Hulk-inspired user interface that adapts to different screen sizes.
  
## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK**: Comes with Flutter
- **Firebase Account**: Set up a Firebase project

### Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/yourusername/hulkify.git
    cd hulkify
    ```

2. **Install dependencies:**

    ```bash
    flutter pub get
    ```

3. **Set up Firebase:**

   - Go to [Firebase Console](https://console.firebase.google.com/) and create a new project.
   - Add Android app to the Firebase project and download the `google-services.json` file.
   - Place the `google-services.json` file in your project's `android/app` directory.
   - Enable **Firebase Authentication** and set up email/password authentication.

4. **Run the app:**

    ```bash
    flutter run
    ```

## 🔧 Project Structure

- **lib/main.dart**: The entry point of the application.
- **lib/screens/**: Contains all the UI screens (login, home, playlist, etc.).
- **lib/services/**: Firebase authentication and other backend services.
- **lib/widgets/**: Reusable widgets (custom buttons, list items, etc.).

## 🛠 Technologies Used

- **Flutter & Dart**: For building cross-platform mobile applications.
- **Firebase Authentication**: For secure user login and registration.


  


Feel free to fork this project, create pull requests, and contribute to the app's development. Your ideas and improvements are welcome!
