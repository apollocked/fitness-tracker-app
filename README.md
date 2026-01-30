# 🏋️ Fitness Tracker App

A comprehensive Flutter-based fitness tracking application designed to help users monitor their fitness journey with calculators, goal tracking, and progress visualization.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg)

---

## ✨ Features

### 🔐 Authentication

- **User Registration** - Create accounts with comprehensive validation
- **User Login** - Secure login with email and password
- **Personal Profile Management** - Store and manage user information

### 🧮 Fitness Calculators

- **Daily Calorie Calculator** - Calculate daily calorie needs based on BMR and activity level
- **Ideal Body Weight Calculator** - Determine ideal weight based on height and gender
- **Protein Intake Calculator** - Calculate daily protein requirements (regular & bodybuilder)

### 🎯 Goal Management

- **Weight Goals** - Track progress towards target weight
- **Calorie Goals** - Set and monitor daily calorie intake
- **Protein Goals** - Manage daily protein targets
- **Progress Tracking** - Visual indicators and percentage tracking
- **Auto-sync** - Goals automatically update with calculator results

### 📊 Progress Tracking

- **Weight Measurement Logging** - Record weight updates
- **Progress Visualization** - Track changes over time
- **Goal Achievement Status** - Monitor completion progress
- **Statistics Dashboard** - View overall statistics

### 👤 User Profile

- **Personal Information** - View and manage profile details
- **Account Settings** - Change password and email
- **Goal Management** - Edit and manage fitness goals
- **Account Deletion** - Option to delete account

### 🌙 Theme Support

- **Dark Mode** - Reduce eye strain with dark theme
- **Light Mode** - Traditional light interface
- **Auto-save Theme Preference** - Remember user choice

### ℹ️ Help & Support

- **Feature Documentation** - Learn about all app features
- **FAQs** - Answers to common questions
- **Troubleshooting Guide** - Solutions to common issues
- **Tips & Tricks** - Best practices and recommendations
- **Email Support** - Contact support team

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**

```bash
git clone https://github.com/apollocked/fitness-tracker-app.git
cd fitness-tracker-app
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Run the app**

```bash
flutter run
```

### First Time Setup

1. **Register an account**
   - Open app → Sign Up
   - Fill in all required information
   - Create account

2. **Set your goals**
   - Go to Home → Use calculators
   - Daily Calorie Calculator
   - Ideal Body Weight Calculator
   - Protein Intake Calculator

3. **Start tracking**
   - Go to Home → Update Weight
   - Check Progress page for history
   - Monitor goals in Profile → My Goals

---

## 📁 Project Structure

```
lib/
├── pages/
│   ├── authentication/
│   │   ├── login_page.dart
│   │   ├── register_page.dart
│   │   └── authWidgets/
│   ├── HomePage/
│   │   └── home_page.dart
│   ├── Profile/
│   │   ├── profile_page.dart
│   │   ├── features_page.dart
│   │   ├── help_support_page.dart
│   │   ├── Goals/
│   │   ├── Settings/
│   │   └── ...
│   ├── Cards/
│   │   ├── daily_calorie_page.dart
│   │   ├── ideal_bw_page.dart
│   │   ├── protien_intake_page.dart
│   │   └── add_measurement_page.dart
│   └── progress/
│       └── progress_page.dart
├── Custom_Widgets/
│   ├── custom_appbar.dart
│   ├── custom_textfeild.dart
│   ├── custom_elevated_button.dart
│   └── ...
├── services/
│   ├── goals_service.dart
│   └── registration_validator.dart
├── models/
│   └── measurement_model.dart
├── utils/
│   ├── colors.dart
│   ├── dark_mode_helper.dart
│   └── user_data.dart
└── main.dart
```

---

## 💾 Data Storage

Currently uses **in-memory storage** for demonstration purposes:

```dart
List<Map<String, dynamic>> users = [
  {
    "id": "unique_id",
    "username": "username",
    "email": "email@example.com",
    "password": "password",
    "age": 25,
    "weight": 75.0,
    "height": 180.0,
    "gender": "Male",
    "goals": {
      "weight": {...},
      "calories": {...},
      "protein": {...}
    }
    // ... more fields
  }
];
```

### Future Enhancement: Database Integration

- Firebase for cloud sync

---

## 🎨 UI/UX Features

### Theme Support

- ✅ Dark Mode
- ✅ Light Mode
- ✅ Auto theme switching
- ✅ Persistent theme preference

### Responsive Design

- ✅ Mobile optimized
- ✅ Tablet support
- ✅ Landscape orientation
- ✅ Safe area handling

### User Experience

- ✅ Form validation
- ✅ Error messages
- ✅ Loading indicators
- ✅ Success notifications
- ✅ Intuitive navigation

---

## 🔧 Key Technologies

### Flutter & Dart

```yaml
dependencies:
  flutter:
    sdk: flutter
  intl: ^0.19.0
```

### Architecture

- **State Management**: StatefulWidget & SetState
- **Navigation**: Named Routes & Navigator
- **Form Validation**: GlobalKey & FormState

### Design Patterns

- **MVC Pattern** - Model-View-Controller
- **Singleton Pattern** - Global user data
- **Service Pattern** - Goals management
- **Validator Pattern** - Input validation

---

## 📱 App Navigation

```
Login/Register
    ↓
Home (Dashboard with calculators)
    ├── Daily Calorie Calculator
    ├── Ideal Body Weight Calculator
    ├── Protein Intake Calculator
    └── Update Weight
    ↓
Progress (Measurement history)
    ├── View measurements
    └── Track progress
    ↓
Profile
    ├── Personal Information
    ├── My Goals
    ├── Settings
    │   ├── Dark Mode
    │   ├── Change Password
    │   └── Edit Profile
    ├── Features
    ├── Help & Support
    │   ├── FAQs
    │   ├── Troubleshooting
    │   └── Tips & Tricks
    └── About
```

---

## ✅ Validation Features

### Registration Validation

- ✅ Username (minimum 3 characters)
- ✅ Email (valid format, not registered)
- ✅ Password (minimum 6 characters)
- ✅ Age (13-120 years)
- ✅ Weight (1-300 kg)
- ✅ Height (1-300 cm)
- ✅ Gender selection

### Input Validation

- ✅ Form validation on all inputs
- ✅ Real-time error messages
- ✅ Field-specific validators
- ✅ Range validation for numbers

---

## 🎯 Calculators

### Daily Calorie Calculator

- **Inputs**: Age, Weight, Height, Gender, Activity Level
- **Output**: Daily calorie needs
- **Features**:
  - BMR calculation (Harris-Benedict formula)
  - Activity multiplier adjustments
  - Weight loss/gain calculations

### Ideal Body Weight Calculator

- **Inputs**: Height, Gender, Current Weight
- **Output**: Ideal weight target
- **Features**:
  - Devine formula for calculations
  - Auto-detect goal type (lose/gain/maintain)
  - Progress tracking

### Protein Intake Calculator

- **Inputs**: Weight, Body Type (Regular/Bodybuilder)
- **Output**: Daily protein requirements
- **Features**:
  - Different calculations for fitness levels
  - Range suggestions (min/max)
  - Muscle building recommendations

---

## 🔐 Security Features

- ✅ Local password storage
- ✅ Email validation
- ✅ Input sanitization
- ✅ Session management
- ✅ Account deletion option

**Note**: For production, implement proper backend with encrypted passwords and secure authentication (JWT, OAuth2, etc.)

---

## 📊 Goals System

### Goal Types

1. **Weight Goals**
   - Track loss, gain, or maintenance
   - Visual progress bar
   - Percentage tracking
   - Auto-update with measurements

2. **Calorie Goals**
   - Set daily targets
   - From calculator results
   - Read-only (set from calculator)

3. **Protein Goals**
   - Daily protein intake
   - From calculator results
   - Read-only (set from calculator)

### Goal Tracking

- Progress percentage
- Completion status
- Visual indicators
- Statistics dashboard

---

## 🎨 Customization

### Colors

Edit `lib/utils/colors.dart`:

```dart
Color primaryColor = const Color(0xFFD4AF37);  // Gold
Color redColor = Colors.red;
Color greenColor = Colors.green;
Color blueColor = const Color(0xFF2962FF);
```

### Theme

Edit `lib/utils/dark_mode_helper.dart`:

```dart
Color getCardColor() {
  return isDarkMode() ? darkCard : Colors.white;
}
```

---

## 🚦 Testing

### Test Cases Covered

- ✅ User registration with all validations
- ✅ User login with credentials
- ✅ Calculator calculations
- ✅ Goal creation and updates
- ✅ Dark/Light theme toggle
- ✅ Progress tracking

### How to Test

1. Register new account
2. Set goals using calculators
3. Update measurements
4. Track progress
5. Test dark mode toggle
6. Change settings

---

## 🐛 Known Issues & Future Improvements

### Current Limitations

- ⚠️ No backend integration
- ⚠️ No data export/backup
- ⚠️ No push notifications

### Future Enhancements

- 🔄 Database integration (Firebase)
- 🔄 Cloud synchronization
- 🔄 Push notifications
- 🔄 Social features (sharing goals)
- 🔄 Workout plans
- 🔄 Nutrition tracking
- 🔄 Integration with wearables
- 🔄 Analytics and reports

---

## 📝 API Documentation

### User Data Structure

```dart
{
  "id": String,              // Unique identifier
  "username": String,        // Username
  "email": String,          // Email address
  "password": String,       // Password (hashed in production)
  "age": int,               // Age in years
  "weight": double,         // Current weight in kg
  "height": double,         // Height in cm
  "gender": String,         // "Male" or "Female"
  "isBodybuilder": bool,    // Fitness level
  "darkMode": bool,         // Theme preference
  "createdAt": String,      // Creation date
  "goals": Map<String, Map> // Goals object
}
```

### Goals Structure

```dart
{
  "weight": {
    "target": double,
    "current": double,
    "unit": "kg",
    "active": bool,
    "goalType": "lose|gain|maintain"
  },
  "calories": {
    "target": double,
    "unit": "cal",
    "active": bool
  },
  "protein": {
    "target": double,
    "unit": "g",
    "active": bool
  }
}
```

---

## 📧 Support

### Help & Support

- Check in-app FAQs
- Read troubleshooting guide
- Email: mahamadbarznji712@gmail.com

### Contact

- **Issues**: Create GitHub issue
- **Features**: Submit feature request
- **Feedback**: Email feedback to support

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

```
MIT License

Copyright (c) 2026 Fitness Tracker

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
```

---

## 👥 Contributing

Contributions are welcome! Please follow these steps:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** changes (`git commit -m 'Add some AmazingFeature'`)
4. **Push** to branch (`git push origin feature/AmazingFeature`)
5. **Open** a Pull Request

### Contribution Guidelines

- Follow Dart style guide
- Add comments for complex logic
- Test your changes
- Update documentation

---

## 🙏 Acknowledgments

- Flutter team for amazing framework
- Material Design for UI/UX guidelines
- Community for feedback and support

---

## 📞 Contact

- **Developer**: muhammed jameel barznji
- **Email**: mahamadbarznji712@gmail.com
- **GitHub**: [@apollocked](https://github.com/apollocked)
- **LinkedIn**: [muhammed jameel](https://www.linkedin.com/in/apollocked)

---

## 📊 Statistics

- **Lines of Code**: ~3000+
- **Number of Pages**: 15+
- **Custom Widgets**: 10+
- **Features**: 25+
- **Calculators**: 3

---

## 🎉 Version History

### v1.0.0 (Current)

- ✅ User Authentication
- ✅ Fitness Calculators
- ✅ Goal Management
- ✅ Progress Tracking
- ✅ Dark Mode Support
- ✅ Help & Support

### v1.1.0 (Upcoming)

- 🔄 Database Integration
- 🔄 Cloud Sync
- 🔄 Push Notifications
- 🔄 Social Sharing

---

**Made with ❤️ for fitness enthusiasts**

⭐ Star this repo if you find it helpful!
