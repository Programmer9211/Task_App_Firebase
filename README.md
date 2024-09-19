
# Task Management App with Firebase

This Flutter-based task management app allows users to sign up, log in, and manage a list of tasks. The app utilizes Firebase Authentication for user management, Firestore for data storage, and Firebase Cloud Functions for automatic task count management. Users can add new tasks, delete them, mark them as completed, and see the total number of tasks.

## Features

- **User Authentication**: Sign-up, log-in, and log-out functionalities using Firebase Authentication with email and password.
- **Task Management**: Users can create, delete, and mark tasks as completed.
- **Real-time Task Count**: Firebase Cloud Functions automatically update the task count whenever a task is created or deleted.
- **Firestore**: Each user has their own collection of tasks, and tasks have fields like `title`, `description`, `isCompleted`, and `createdAt`.

## Project Setup Instructions

### Prerequisites

Before setting up the project, make sure you have the following installed:

- [Flutter](https://flutter.dev/docs/get-started/install) (latest version)
- [Dart](https://dart.dev/get-dart)
- [Node.js](https://nodejs.org/en/) (for Firebase Functions)
- Firebase CLI (`npm install -g firebase-tools`)

### Project Setup

1. **Clone the Repository**  
   Clone this repository to your local machine:

   ```bash
   git clone <repository-url>
   cd <project-directory>
   ```

2. **Install Flutter Dependencies**  
   Install the required Flutter dependencies:

   ```bash
   flutter pub get
   ```

3. **Firebase Setup**

   Since you will receive an invite to the Firebase project, you do not need to create a new Firebase project.

   **Steps:**
   - Accept the Firebase project invite.
   - Place the provided `google-services.json` file inside the `android/app/` directory.
   
   Your project structure should look like this:

   ```
   android/app/google-services.json
   ```

### Running the App

Once you have completed the setup, you can run the app by executing the following command:

```bash
flutter run
```

Make sure the Android emulator or physical device is connected.

## Firebase Functions

This project uses Firebase Cloud Functions to handle the task count. The following functions are automatically triggered when tasks are created or deleted:

- **Increment Task Count**: This function increases the task count when a new task is added.
- **Decrement Task Count**: This function decreases the task count when a task is deleted.

You can find the Firebase functions code in the `functions` directory.

## Notes

- Make sure to include the correct Firebase configurations in `google-services.json`.
