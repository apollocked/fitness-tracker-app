# Fitness Tracker App

A comprehensive Flutter-based fitness tracking application to help users monitor their fitness journey with calculators, goal tracking, progress visualization, and optional weight reminders.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg)

---

## Features

### Authentication & Onboarding
- **Onboarding Carousel** — 5 animated slides introducing the app on first launch
- **User Registration** — Create a profile with username, passkey (6+ characters, alphanumeric + symbols), age, weight, height, and gender
- **User Login** — Secure login with username + passkey; passkey visibility toggle
- **Guest Mode** — Browse without saving; all data-write actions blocked by a guard dialog
- **Rate Limiting** — Login locks out for 1 minute after 5 failed attempts; remaining attempts shown in error message
- **Passkey Hashing** — Passkeys stored as HMAC-SHA256 hash with per-user 16-byte salt; never stored in plaintext
- **Passkey Visibility Toggle** — Show/hide passkey on both login and registration forms

### Fitness Calculators
- **Daily Calorie Calculator** — Calculates BMR (Mifflin-St Jeor formula) & TDEE based on age, weight, height, gender, activity level, and goal type (lose/gain/maintain). Supports weekly weight goal adjustment (0.25–1 kg).
- **Ideal Body Weight Calculator** — Uses the Devine formula based on height and gender. Auto-detects goal type (lose/gain/maintain) and shows progress toward ideal weight.
- **Protein Intake Calculator** — Computes daily protein needs for regular (0.8 g/kg) and bodybuilder (1.2–2.0 g/kg) levels.

### Goal Management
- **Weight Goals** — Track progress toward target weight with goal type (lose/gain/maintain) and start-weight tracking
- **Calorie Goals** — Auto-sync from daily calorie calculator results
- **Protein Goals** — Auto-sync from protein calculator results
- **Progress Bars** — Visual percentage indicators with color-coded status
- **Goal Editing** — Edit target, current value, goal type, and active/inactive state
- **Smart Auto-Sync** — Goals automatically update when using calculators or adding measurements

### Progress Tracking
- **Weight Measurement Logging** — Record weight entries with date
- **Reverse-Chronological List** — View history sorted by most recent
- **Auto-Sync with Profile** — Adding a measurement updates the user's current weight and weight goal progress
- **Empty State UI** — Friendly prompt when no measurements exist

### Notifications
- **Weight Reminder** — Optional reminder every 3 days (32 scheduled notifications)
- **Permission Handling** — Requests notification access on supported platforms

### User Profile
- **Personal Information** — View username, age, height, weight, gender
- **Edit Profile** — Change username via dialog
- **Settings** — Dark mode toggle, notification toggle, privacy policy, terms & conditions
- **Goal Management** — Full goals dashboard with stats (total, active, completed)
- **Account Deletion** — Permanently delete profile and all data
- **Logout** — Confirmation dialog before signing out
- **Guest Profile** — Dedicated guest view with benefits card, dark mode toggle, and app info links

### Theme Support
- **Dark Mode** — Full dark theme
- **Light Mode** — Traditional light interface
- **Persistent Preference** — Theme choice saved per-user (guest dark mode stored separately)
- **Gold Accent** — Custom gold (#D4AF37) primary color scheme

### Help & Support
- **FAQs** — Accordion-style frequently asked questions
- **Troubleshooting Guide** — Common issues with solutions
- **Tips & Tricks** — Best practices and recommendations
- **Feature Documentation** — Learn about all app features
- **Email Support** — Contact the development team

### Legal Pages
- **Privacy Policy** — 6 sections covering data collection, usage, storage, rights, children's privacy, and policy changes
- **Terms & Conditions** — 10 sections covering eligibility, usage, health disclaimer, liability, and more

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

1. **Create a profile** — Sign up with username, passkey, age, weight, height, and gender
2. **Set your goals** — Use calculators on the Home tab (Daily Calorie, Ideal Body Weight, Protein Intake)
3. **Start tracking** — Log weight measurements, check Progress tab for history, monitor goals in Profile

---

## Project Structure

```
lib/
├── main.dart                     # App entry point with DI setup
├── core/
│   └── theme/                    # Light/dark theme definitions & custom ThemeExtension
├── data/
│   ├── model/                    # Data models (UserModel, Measurement)
│   ├── repositories/             # Abstract repository interfaces + local Hive implementations
│   └── services/                 # Hive storage, notification service, validation
├── logic/                        # ViewModels (ChangeNotifier state management)
├── presentation/
│   ├── pages/                    # 18 screen pages across auth, calculators, profile, settings
│   └── widgets/                  # 40+ reusable UI components
```

---

## Architecture

### MVVM with Provider

The app follows the **Model-View-ViewModel** pattern using Flutter's `provider` package for state management.

```
User Action → View (Page) → ViewModel (ChangeNotifier) → Repository → Hive Storage
                    ↑               │
                    └── notifyListeners() ───┘
```

- **Models** (`data/model/`) — `UserModel` and `Measurement` data classes
- **Repositories** (`data/repositories/`) — Abstract interfaces with `Local*` implementations using Hive
- **Services** (`data/services/`) — `HiveStorageService`, `NotificationService`, `RegistrationValidator`
- **ViewModels** (`logic/`) — 5 ChangeNotifier classes: `AuthViewModel`, `AppViewModel`, `GoalsViewModel`, `ProgressViewModel`, `CalculatorsViewModel`
- **Pages** (`presentation/pages/`) — Widgets consuming ViewModels via `context.watch<>()` and `context.read<>()`
- **Widgets** (`presentation/widgets/`) — Reusable component library organized by feature

### ViewModels (5)

| ViewModel | Responsibility |
|-----------|---------------|
| **AuthViewModel** | Login, register, guest mode, logout, delete account |
| **AppViewModel** | Theme mode, navigation index, notification settings, profile updates |
| **CalculatorsViewModel** | Pure computation: BMR, TDEE, calorie adjustment, BMI, ideal weight, protein |
| **GoalsViewModel** | Goal CRUD, progress calculation, status colors, auto-sync |
| **ProgressViewModel** | Measurement CRUD, reverse-chronological list |

---

## Data Storage

Uses **Hive** with **AES-256 encryption** for local persistence (100% offline, no backend):

- **Encryption Key** — Stored in platform Keystore/Keychain via `flutter_secure_storage`; generated once on first launch
- **Users** — JSON-encoded user profiles stored per-user (passkey is hashed, never plaintext)
- **Session** — Only the user ID is stored in the session; full user reconstructed from the users list
- **Measurements** — Per-user weight history (`measurements_{username}` key)
- **Settings** — Theme preference, notification toggle, guest dark mode, onboarding seen flag

### Goals Data Structure

```dart
{
  "weight": {
    "target": double, "current": double, "unit": "kg",
    "active": bool, "goalType": "lose|gain|maintain", "startWeight": double
  },
  "calories": {
    "target": double, "unit": "cal", "active": bool
  },
  "protein": {
    "target": double, "unit": "g", "active": bool
  }
}
```

---

## Calculators & Formulas

### Daily Calorie (Mifflin-St Jeor)
- **BMR (Male)** = 10w + 6.25h − 5a + 5
- **BMR (Female)** = 10w + 6.25h − 5a − 161
- **TDEE** = BMR × activity multiplier (1.2–1.9)
- **Adjustment** = ±(weeklyGoal × 7700 ÷ 7) kcal/day
- **Daily Calories** = (TDEE + adjustment) rounded to nearest 10

### Ideal Body Weight (Devine)
- **Male**: 50 + 0.91 × (height(cm) − 152.4)
- **Female**: 45.5 + 0.91 × (height(cm) − 152.4)

### Protein Intake
- **Regular**: 0.8 g/kg
- **Bodybuilder**: 1.2–2.0 g/kg

---

## UI/UX

- Material 3 design with custom gold theme
- Dark & light mode with persistent preference
- Guest mode with sticky banner and guarded data writes
- Passkey visibility toggle on all auth forms
- Loading indicators, snackbar notifications, error messages
- Form validation with field-specific validators

---

## Navigation

```
Onboarding (first launch)
    ↓
Login
    ├── Register (push)
    ├── Onboarding (push)
    └── Layout (3 tabs)
        ├── Home → calculators, add measurement (push)
        ├── Progress → add measurement (push)
        └── Profile
            ├── Personal Info (push)
            ├── Goals (push)
            ├── Settings (push)
            │   ├── Edit Profile (dialog)
            │   ├── Privacy Policy (route)
            │   └── Terms & Conditions (route)
            ├── Help & Support (push)
            ├── Features (route)
            └── About (push)
```

---

## Key Technologies

```yaml
dependencies:
  flutter: sdk
  provider: ^6.1.0           # State management (MVVM)
  hive: ^2.2.3               # Local persistence
  hive_flutter: ^1.1.0       # Hive Flutter adapter
  crypto: ^3.0.6             # HMAC-SHA256 passkey hashing
  flutter_secure_storage: ^9.2.4  # Hive encryption key storage
  flutter_local_notifications: ^22.0.0  # Weight reminders
  permission_handler: ^12.0.3  # Notification permission
  timezone: ^0.11.0          # Timezone handling
  intl: ^0.20.2              # Date formatting
  shared_preferences: (migrated to Hive)
```

---

## Statistics

- **Lines of Code**: ~6,700+
- **Dart Files**: 78
- **Pages**: 18
- **Custom Widgets**: 40+
- **Features**: 25+
- **Calculators**: 3
- **ViewModels**: 5
- **Data Models**: 2

---

## Version History

### v2.2.0 (Current)
- User Registration & Login with passkey visibility toggle
- Guest Mode with guarded data writes
- Onboarding Carousel
- Fitness Calculators (Calorie, Ideal Weight, Protein)
- Goal Management (Weight, Calorie, Protein) with auto-sync
- Progress Tracking with weight measurement history
- Weight Reminder Notifications (every 3 days)
- Dark/Light Theme with persistent preference
- Personal Profile & Settings
- Privacy Policy & Terms & Conditions
- Help & Support (FAQ, Troubleshooting, Tips)
- MVVM architecture with Provider
- Hive + flutter_secure_storage for encrypted persistence
- **Security**: HMAC-SHA256 passkey hashing, AES-256 Hive encryption, rate-limited login, session as user ID only, ProGuard obfuscation

---

## Support

- **In-app Help**: Check FAQs, Troubleshooting, and Tips
- **Email**: mahamadbarznji712@gmail.com
- **Issues**: Create a GitHub issue on the repository

---

## License

This project is licensed under the MIT License.

---

## Contact

- **Developer**: Mohammed Jameel
- **Email**: mahamadbarznji712@gmail.com
- **GitHub**: [@apollocked](https://github.com/apollocked)

---

## Contributing

Contributions are welcome! Fork the repo, create a feature branch, commit changes, and open a Pull Request.

---

**Made for fitness enthusiasts 💪**
