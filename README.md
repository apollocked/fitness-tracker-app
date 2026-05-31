# Fitness Tracker App

A comprehensive Flutter-based fitness tracking application designed to help users monitor their fitness journey with calculators, goal tracking, and progress visualization.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg)

---

## Features

### Authentication
- **User Registration** - Create accounts with comprehensive validation
- **User Login** - Secure login with email and password
- **Personal Profile Management** - Store and manage user information

### Fitness Calculators
- **Daily Calorie Calculator** - Calculate daily calorie needs based on BMR and activity level
- **Ideal Body Weight Calculator** - Determine ideal weight based on height and gender
- **Protein Intake Calculator** - Calculate daily protein requirements (regular & bodybuilder)

### Goal Management
- **Weight Goals** - Track progress towards target weight
- **Calorie Goals** - Set and monitor daily calorie intake
- **Protein Goals** - Manage daily protein targets
- **Progress Tracking** - Visual indicators and percentage tracking
- **Auto-sync** - Goals automatically update with calculator results

### Progress Tracking
- **Weight Measurement Logging** - Record weight updates
- **Progress Visualization** - Track changes over time
- **Goal Achievement Status** - Monitor completion progress

### User Profile
- **Personal Information** - View and manage profile details
- **Account Settings** - Change password and email
- **Goal Management** - Edit and manage fitness goals
- **Account Deletion** - Option to delete account

### Theme Support
- **Dark Mode** - Reduce eye strain with dark theme
- **Light Mode** - Traditional light interface
- **Auto-save Theme Preference** - Remember user choice

### Help & Support
- **Feature Documentation** - Learn about all app features
- **FAQs** - Answers to common questions
- **Troubleshooting Guide** - Solutions to common issues
- **Tips & Tricks** - Best practices and recommendations
- **Email Support** - Contact support team

---

## Getting Started

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
   - Open app, sign up, and fill in all required information
2. **Set your goals**
   - Go to Home, use calculators (Daily Calorie, Ideal Body Weight, Protein Intake)
3. **Start tracking**
   - Go to Home, update weight, check Progress page for history, monitor goals in Profile

---

## Project Structure

```
lib/
├── main.dart                              # App entry point with DI setup
├── core/
│   └── theme/                             # Light/dark theme definitions
├── data/
│   ├── model/                             # Data models
│   ├── repositories/                      # Repositories 
│   └── services/                          # Services 
├── logic/                                 # ViewModels (State Management)  
├── presentation/
│   ├── pages/                             # All screen pages 
│   └── widgets/                           # Reusable UI 
```

---

## Architecture

### MVVM with Provider

The app follows the **Model-View-ViewModel** pattern using Flutter's `provider` package for state management.

```
User Action → View (Page) → ViewModel (ChangeNotifier) → Service/Repository → Model
                    ↑               │
                    └── notifyListeners() ───┘
```

- **Models** (`data/model/`) - Data classes for User and Measurement
- **Services** (`data/services/`) - Repositories abstracting local storage (SharedPreferences)
- **ViewModels** (`logic/porviders/`) - ChangeNotifier classes holding UI state and business logic
- **Pages** (`presentation/pages/`) - StatelessWidget/StatefulWidget screens consuming ViewModels via `context.watch<>()` and `context.read<>()`
- **Widgets** (`presentation/widgets/`) - Reusable UI components


---

## Data Storage

Currently uses **SharedPreferences** for local persistence:

- **Users** - JSON-encoded user profiles stored in SharedPreferences
- **Measurements** - JSON-encoded weight measurement history
- **Settings** - Theme preference persisted per-user

Data is loaded on app startup via `StorageService.init()` and `LocalUserRepository.reloadFromStorage()`.

### Goals Data Structure

```dart
{
  "weight": {
    "target": double,
    "current": double,
    "unit": "kg",
    "active": bool,
    "goalType": "lose|gain|maintain",
    "startWeight": double
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

## UI/UX Features

### Theme Support
- Dark Mode
- Light Mode
- Auto theme switching
- Persistent theme preference

### Responsive Design
- Mobile optimized
- Tablet support
- Landscape orientation
- Safe area handling

### User Experience
- Form validation
- Error messages
- Loading indicators
- Success notifications
- Intuitive navigation

---

## Key Technologies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.0        # State management (MVVM)
  shared_preferences: >=2.4.21  # Local persistence
  intl: ^0.20.2           # Date formatting
  flutter_secure_storage: ^10.0.0  # Secure credential storage
  hive: ^2.2.3            # Local database
  path_provider: ^2.0.15  # File system paths
```

---

## App Navigation

```
Login/Register
    ↓
Home (Dashboard with calculator cards)
    ├── Daily Calorie Calculator
    ├── Ideal Body Weight Calculator
    ├── Protein Intake Calculator
    └── Update Weight
    ↓
Progress (Measurement history)
    ├── View measurements
    └── Add new measurement
    ↓
Profile
    ├── Personal Information
    ├── My Goals
    ├── Settings
    │   ├── Dark Mode Toggle
    │   ├── Terms & Conditions
    │   └── Privacy Policy
    ├── Features
    ├── Help & Support
    └── About
```

---

## Validation Features

### Registration Validation
- Username (minimum 3 characters)
- Email (valid format, not registered)
- Password (minimum 6 characters)
- Age (13-120 years)
- Weight (1-300 kg)
- Height (1-300 cm)
- Gender selection

### Input Validation
- Form validation on all inputs
- Real-time error messages
- Field-specific validators
- Range validation for numbers

---

## Calculators

### Daily Calorie Calculator
- **Inputs**: Age, Weight, Height, Gender, Activity Level
- **Output**: Daily calorie needs
- **Features**: BMR calculation (Mifflin-St Jeor), activity multiplier, weight loss/gain adjustments

### Ideal Body Weight Calculator
- **Inputs**: Height, Gender, Current Weight (optional target)
- **Output**: Ideal weight target
- **Features**: Devine formula, auto-detect goal type (lose/gain/maintain), progress tracking

### Protein Intake Calculator
- **Inputs**: Weight, Body Type (Regular/Bodybuilder)
- **Output**: Daily protein requirements
- **Features**: Different calculations for fitness levels, range suggestions (min/max)

---


### Theme

Edit `lib/core/theme/app_theme.dart` to customize light/dark theme properties.

---

## Testing

### How to Test
1. Register a new account
2. Set goals using calculators
3. Update measurements
4. Track progress
5. Test dark mode toggle
6. Change settings

---

## Known Issues & Future Improvements

### Current Limitations
- No backend integration
- No data export/backup
- No push notifications

### Future Enhancements
- Database integration (Firebase)
- Cloud synchronization
- Push notifications
- Social features (sharing goals)
- Analytics and reports

---

## Support

### Help & Support
- Check in-app FAQs
- Read troubleshooting guide
- Email: mahamadbarznji712@gmail.com

### Contact
- **Issues**: Create GitHub issue
- **Features**: Submit feature request
- **Feedback**: Email feedback to support

---

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## Contact

- **Developer**: muhammed jameel 
- **Email**: mahamadbarznji712@gmail.com
- **GitHub**: [@apollocked](https://github.com/apollocked)
- **LinkedIn**: [muhammed jameel](https://www.linkedin.com/in/apollocked)

---

## Statistics

- **Lines of Code**: ~3000+
- **Number of Pages**: 15+
- **Custom Widgets**: 20+
- **Features**: 25+
- **Calculators**: 3

---

## Version History

### v2.0.0 (Current)
- User Authentication
- Fitness Calculators
- Goal Management
- Progress Tracking
- Dark Mode Support
- Help & Support
- MVVM architecture with Provider

### v2.1.0 (Upcoming)
- Database Integration
- Cloud Sync
- Push Notifications
- Social Sharing

---

**Made with ❤️ in Kurdistan ⛰️ for fitness enthusiasts 💪**

Star this repo if you find it helpful!
