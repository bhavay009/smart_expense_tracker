# Smart Expense Tracker

A Flutter mobile/web app to track expenses with Firebase backend.

## Features

- Add expense with amount, category, note, and date
- View all expenses grouped by date
- Live Firestore data updates
- Weekly and monthly spending insights
- Category-wise expense breakdown
- Smart spending comparison insights

## Tech Stack

- Flutter
- Dart
- Firebase Firestore

## How to Run

1. Clone repository
2. Run `flutter pub get`
3. Configure Firebase
4. Run `flutter run`

## Firebase Collection

expenses

Fields:
- amount
- category
- note
- date

## Project Structure

lib/
- main.dart
- screens/

## Deliverables Info

### Approach and Architecture
The app follows a simple Flutter architecture. It uses `StreamBuilder` connected to Firestore to supply real-time updates for the Expense List and Insights screens. The UI is separated into individual page widgets under the `screens` directory. State management relies on basic `StatefulWidget` for the input form and `StreamBuilder` for fetching the latest data automatically when the backend changes.

### Backend Choice
The app uses **Firebase Firestore** as its backend. Firebase was chosen because it allows for rapid setup and provides out-of-the-box real-time subscriptions, removing the need to manually fetch updates or set up WebSockets. It also acts as a NoSQL database seamlessly storing expense documents with varied fields.

### Assumptions or Trade-offs
- Authentication is assumed to be out-of-scope for this basic prototype, so there are no user specific filters; all users see all expenses globally.
- The "Insights" screen computes weekly/monthly spending client-side rather than delegating complex data-aggregation to the backend, which is a trade-off made for simplicity given the small expected data size.

## Author

Bhavay Goyal