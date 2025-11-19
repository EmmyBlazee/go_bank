# Go Bank

A comprehensive Flutter-based mobile banking application that provides users with a seamless and secure banking experience. Go Bank offers features like money transfers, airtime top-ups, data purchases, bill payments, transaction history, and more.

## Features

### Core Banking Features
- **Account Overview**: View current balance and account details
- **Money Transfers**: Transfer money to other bank accounts with bank selection, account verification, and secure PIN authentication
- **Airtime Top-up**: Recharge mobile phones with support for major Nigerian networks (MTN, Airtel, Glo, 9mobile)
- **Data Purchases**: Buy data bundles for mobile internet with various package options
- **Bill Payments**: Pay for utilities including cable TV (DSTV, GOTV), electricity, and other services
- **Transaction History**: View detailed history of all transactions with pull-to-refresh functionality
- **Notifications**: Receive and manage transaction notifications with mark-all-read functionality

### User Management
- **User Authentication**: Login and signup screens for secure access
- **Onboarding**: Guided first-time user experience
- **Profile Management**: View and edit user profile information
- **More Services**: Access to additional banking services through a grid layout

### Technical Features
- **GoRouter Navigation**: Modern routing with deep linking support
- **Responsive Design**: Optimized for mobile devices with Material Design
- **Reusable Widgets**: Custom components for consistent UI/UX
- **State Management**: Efficient state handling for user interactions

## Prerequisites

Before running this project, ensure you have the following installed:

- **Flutter SDK**: Version 3.9.2 or higher
- **Dart SDK**: Included with Flutter
- **Android Studio** or **VS Code** with Flutter extensions
- **Android SDK** (for Android development)
- **Xcode** (for iOS development on macOS)

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/go_bank.git
   cd go_bank
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Verify installation**:
   ```bash
   flutter doctor
   ```

## Setup

### Android Setup
1. Ensure Android SDK is properly configured
2. Create an Android Virtual Device (AVD) or connect a physical device
3. Enable USB debugging on your device (for physical devices)

### iOS Setup (macOS only)
1. Ensure Xcode is installed and configured
2. Install CocoaPods if not already installed:
   ```bash
   sudo gem install cocoapods
   ```
3. Navigate to the iOS folder and install pods:
   ```bash
   cd ios
   pod install
   cd ..
   ```

## Usage

### Running the App

1. **Connect a device or start an emulator/simulator**

2. **Run the app**:
   ```bash
   flutter run
   ```

### App Flow

1. **Splash Screen**: Initial loading screen (5 seconds)
2. **Welcome Screen**: Introduction to the app
3. **Authentication**: Login or signup to access the app
4. **Onboarding**: First-time user setup (if applicable)
5. **Home Screen**: Main dashboard with account balance and quick actions
6. **Services**: Access various banking services through the navigation

### Navigation

The app uses GoRouter for navigation. Key routes include:
- `/splash` - Splash screen
- `/welcome` - Welcome screen
- `/login` - User login
- `/signup` - User registration
- `/onboarding` - User onboarding
- `/home` - Main dashboard (protected route)
- `/transfer-choice` - Transfer options
- `/airtime-provider` - Airtime provider selection
- `/data-provider` - Data provider selection
- `/bills-category` - Bill payment categories
- `/transaction-history` - Transaction history
- `/profile` - User profile

### Testing

Run tests using:
```bash
flutter test
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── router.dart               # GoRouter configuration
├── main_scaffold.dart        # Main app scaffold with bottom navigation
├── colors.dart               # App color constants
├── screens/                  # All screen widgets
│   ├── splash_screen.dart
│   ├── welcome_screen.dart
│   ├── login_screen.dart
│   ├── sign_up_screen.dart
│   ├── onboarding_screen.dart
│   ├── home_screen.dart
│   ├── transfer_choice_screen.dart
│   ├── bank_selection_screen.dart
│   ├── account_number_screen.dart
│   ├── amount_screen.dart
│   ├── confirm_details_screen.dart
│   ├── pin_screen.dart
│   ├── success_screen.dart
│   ├── airtime_provider_screen.dart
│   ├── airtime_phone_screen.dart
│   ├── airtime_amount_screen.dart
│   ├── airtime_confirm_screen.dart
│   ├── airtime_amount_screen.dart
│   ├── airtime_success_screen.dart
│   ├── data_provider_screen.dart
│   ├── data_package_screen.dart
│   ├── data_phone_screen.dart
│   ├── data_confirm_screen.dart
│   ├── data_success_screen.dart
│   ├── bills_category_screen.dart
│   ├── bills_provider_screen.dart
│   ├── bills_package_screen.dart
│   ├── bills_smartcard_screen.dart
│   ├── bills_confirm_screen.dart
│   ├── bills_success_screen.dart
│   ├── transaction_history_screen.dart
│   ├── more_services_screen.dart
│   ├── notifications_screen.dart
│   ├── profile_screen.dart
│   └── profile_details_screen.dart
├── widgets/                  # Reusable UI components
│   ├── custom_button.dart
│   ├── custom_button.dart
│   ├── custom_text_field.dart
│   ├── transaction_tile.dart
│   ├── bank_logo.dart
│   └── widgets.dart
└── services/                 # Business logic and API services (future)
```

## Dependencies

- **go_router**: Declarative routing for Flutter
- **flutter/material.dart**: Material Design components

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, email support@gobank.com or join our Discord community.

## Roadmap

- [ ] Add biometric authentication
- [ ] Implement dark mode
- [ ] Add push notifications
- [ ] Integrate with real banking APIs
- [ ] Add multi-language support
- [ ] Implement offline transaction queuing
