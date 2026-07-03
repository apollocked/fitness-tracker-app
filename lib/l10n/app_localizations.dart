import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_ckb.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('ckb'),
    Locale('en'),
    Locale('es')
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'FitTracker'**
  String get appTitle;

  /// Material app title for OS
  ///
  /// In en, this message translates to:
  /// **'Fitness Tracker'**
  String get appMaterialTitle;

  /// No description provided for @appDescriptionLocal.
  ///
  /// In en, this message translates to:
  /// **'Your local-only fitness tracker. All data stays on your device.'**
  String get appDescriptionLocal;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get appVersion;

  /// No description provided for @appRightsReserved.
  ///
  /// In en, this message translates to:
  /// **'All rights reserved.'**
  String get appRightsReserved;

  /// No description provided for @appDataStaysLocal.
  ///
  /// In en, this message translates to:
  /// **'Your data stays on your device. Always.'**
  String get appDataStaysLocal;

  /// No description provided for @appNoAccountNeeded.
  ///
  /// In en, this message translates to:
  /// **'No account needed — everything is saved locally.'**
  String get appNoAccountNeeded;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get commonConfirm;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonGotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it!'**
  String get commonGotIt;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get commonNext;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get commonSettings;

  /// No description provided for @commonLearnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get commonLearnMore;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// Bottom nav: Home tab
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Bottom nav: Progress tab
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get navProgress;

  /// Bottom nav: Profile tab
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// Floating button tooltip to add a weight measurement
  ///
  /// In en, this message translates to:
  /// **'Add Measurement'**
  String get navAddMeasurement;

  /// No description provided for @exitTitle.
  ///
  /// In en, this message translates to:
  /// **'Exit App?'**
  String get exitTitle;

  /// No description provided for @exitMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit the app?'**
  String get exitMessage;

  /// No description provided for @exitConfirm.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exitConfirm;

  /// No description provided for @exitStay.
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get exitStay;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// No description provided for @greetingGeneric.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get greetingGeneric;

  /// No description provided for @greetingWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get greetingWelcomeBack;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @homeMyStats.
  ///
  /// In en, this message translates to:
  /// **'My Stats'**
  String get homeMyStats;

  /// No description provided for @homeWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get homeWeight;

  /// No description provided for @homeGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get homeGoal;

  /// No description provided for @homeCalculators.
  ///
  /// In en, this message translates to:
  /// **'Calculators'**
  String get homeCalculators;

  /// No description provided for @homeRecentWeight.
  ///
  /// In en, this message translates to:
  /// **'Recent Weight'**
  String get homeRecentWeight;

  /// No description provided for @homeNoMeasurementsYet.
  ///
  /// In en, this message translates to:
  /// **'No measurements yet'**
  String get homeNoMeasurementsYet;

  /// No description provided for @homeDailyTip.
  ///
  /// In en, this message translates to:
  /// **'Daily Tip'**
  String get homeDailyTip;

  /// No description provided for @homeQuickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get homeQuickActions;

  /// No description provided for @homeBmiCalculator.
  ///
  /// In en, this message translates to:
  /// **'BMI Calculator'**
  String get homeBmiCalculator;

  /// No description provided for @homeProteinIntake.
  ///
  /// In en, this message translates to:
  /// **'Protein Intake'**
  String get homeProteinIntake;

  /// No description provided for @homeCalorieCalculator.
  ///
  /// In en, this message translates to:
  /// **'Calorie Calculator'**
  String get homeCalorieCalculator;

  /// No description provided for @homeMacroCalculator.
  ///
  /// In en, this message translates to:
  /// **'Macro Calculator'**
  String get homeMacroCalculator;

  /// No description provided for @homeYourGoals.
  ///
  /// In en, this message translates to:
  /// **'Your Goals'**
  String get homeYourGoals;

  /// No description provided for @homeNoGoalsSet.
  ///
  /// In en, this message translates to:
  /// **'No goals set yet'**
  String get homeNoGoalsSet;

  /// No description provided for @homeAddFirstGoal.
  ///
  /// In en, this message translates to:
  /// **'Add your first goal'**
  String get homeAddFirstGoal;

  /// No description provided for @homeTapToView.
  ///
  /// In en, this message translates to:
  /// **'Tap to view'**
  String get homeTapToView;

  /// No description provided for @homeWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get homeWeekly;

  /// No description provided for @homeMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get homeMonthly;

  /// No description provided for @homeCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get homeCustom;

  /// No description provided for @progressTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progressTitle;

  /// No description provided for @progressGoalProgress.
  ///
  /// In en, this message translates to:
  /// **'Goal Progress'**
  String get progressGoalProgress;

  /// No description provided for @progressGoalFor.
  ///
  /// In en, this message translates to:
  /// **'Goal for'**
  String get progressGoalFor;

  /// No description provided for @progressAchieved.
  ///
  /// In en, this message translates to:
  /// **'Achieved'**
  String get progressAchieved;

  /// No description provided for @progressRemaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get progressRemaining;

  /// No description provided for @progressWeightChange.
  ///
  /// In en, this message translates to:
  /// **'Weight Change'**
  String get progressWeightChange;

  /// No description provided for @progressFromStart.
  ///
  /// In en, this message translates to:
  /// **'From start'**
  String get progressFromStart;

  /// No description provided for @progressLastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get progressLastMonth;

  /// No description provided for @progressNoMeasurements.
  ///
  /// In en, this message translates to:
  /// **'No measurements recorded yet'**
  String get progressNoMeasurements;

  /// No description provided for @progressTapButton.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button below to log your first measurement'**
  String get progressTapButton;

  /// No description provided for @progressAddMeasurement.
  ///
  /// In en, this message translates to:
  /// **'Add Measurement'**
  String get progressAddMeasurement;

  /// No description provided for @progressMeasurements.
  ///
  /// In en, this message translates to:
  /// **'Measurements'**
  String get progressMeasurements;

  /// No description provided for @progressLogFirstWeight.
  ///
  /// In en, this message translates to:
  /// **'Log your first weight to see trends'**
  String get progressLogFirstWeight;

  /// No description provided for @progressSetGoalFirst.
  ///
  /// In en, this message translates to:
  /// **'Set a weight goal first'**
  String get progressSetGoalFirst;

  /// No description provided for @progressCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get progressCurrent;

  /// No description provided for @progressStarting.
  ///
  /// In en, this message translates to:
  /// **'Starting'**
  String get progressStarting;

  /// No description provided for @progressTarget.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get progressTarget;

  /// No description provided for @progressKg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get progressKg;

  /// No description provided for @progressLb.
  ///
  /// In en, this message translates to:
  /// **'lb'**
  String get progressLb;

  /// No description provided for @progressLbs.
  ///
  /// In en, this message translates to:
  /// **'lbs'**
  String get progressLbs;

  /// No description provided for @progressWeightChart.
  ///
  /// In en, this message translates to:
  /// **'Weight Trend'**
  String get progressWeightChart;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileGuestUser.
  ///
  /// In en, this message translates to:
  /// **'Guest User'**
  String get profileGuestUser;

  /// No description provided for @profileBodyStats.
  ///
  /// In en, this message translates to:
  /// **'Body Stats'**
  String get profileBodyStats;

  /// No description provided for @profileGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get profileGoals;

  /// No description provided for @profileSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileSettings;

  /// No description provided for @profileAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get profileAbout;

  /// No description provided for @profileFeatures.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get profileFeatures;

  /// No description provided for @profileHelpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get profileHelpSupport;

  /// No description provided for @profilePrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get profilePrivacyPolicy;

  /// No description provided for @profileTermsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get profileTermsConditions;

  /// No description provided for @profileEditBodyStats.
  ///
  /// In en, this message translates to:
  /// **'Edit Body Stats'**
  String get profileEditBodyStats;

  /// No description provided for @profileViewGoals.
  ///
  /// In en, this message translates to:
  /// **'View & manage your goals'**
  String get profileViewGoals;

  /// No description provided for @profileCustomizeApp.
  ///
  /// In en, this message translates to:
  /// **'Customize your app experience'**
  String get profileCustomizeApp;

  /// No description provided for @profileLearnApp.
  ///
  /// In en, this message translates to:
  /// **'Learn about this app'**
  String get profileLearnApp;

  /// No description provided for @profileGetHelp.
  ///
  /// In en, this message translates to:
  /// **'Get help and support'**
  String get profileGetHelp;

  /// No description provided for @bodyStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Body Stats'**
  String get bodyStatsTitle;

  /// No description provided for @bodyStatsAge.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get bodyStatsAge;

  /// No description provided for @bodyStatsGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get bodyStatsGender;

  /// No description provided for @bodyStatsMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get bodyStatsMale;

  /// No description provided for @bodyStatsFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get bodyStatsFemale;

  /// No description provided for @bodyStatsOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get bodyStatsOther;

  /// No description provided for @bodyStatsHeight.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get bodyStatsHeight;

  /// No description provided for @bodyStatsWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get bodyStatsWeight;

  /// No description provided for @bodyStatsCm.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get bodyStatsCm;

  /// No description provided for @bodyStatsUnitCm.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get bodyStatsUnitCm;

  /// No description provided for @bodyStatsKg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get bodyStatsKg;

  /// No description provided for @bodyStatsYears.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get bodyStatsYears;

  /// No description provided for @bodyStatsTargetWeight.
  ///
  /// In en, this message translates to:
  /// **'Target Weight'**
  String get bodyStatsTargetWeight;

  /// No description provided for @bodyStatsSave.
  ///
  /// In en, this message translates to:
  /// **'Save Body Stats'**
  String get bodyStatsSave;

  /// No description provided for @goalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Goals'**
  String get goalsTitle;

  /// No description provided for @goalsNoGoalsYet.
  ///
  /// In en, this message translates to:
  /// **'No goals set yet'**
  String get goalsNoGoalsYet;

  /// No description provided for @goalsStartCalculating.
  ///
  /// In en, this message translates to:
  /// **'Start by using a calculator below to set your first goal!'**
  String get goalsStartCalculating;

  /// No description provided for @goalsBmiCategory.
  ///
  /// In en, this message translates to:
  /// **'BMI Category'**
  String get goalsBmiCategory;

  /// No description provided for @goalsTargetBmi.
  ///
  /// In en, this message translates to:
  /// **'Target BMI'**
  String get goalsTargetBmi;

  /// No description provided for @goalsDailyProtein.
  ///
  /// In en, this message translates to:
  /// **'Daily Protein Intake'**
  String get goalsDailyProtein;

  /// No description provided for @goalsDailyCalories.
  ///
  /// In en, this message translates to:
  /// **'Daily Calorie Intake'**
  String get goalsDailyCalories;

  /// No description provided for @goalsMacroSplit.
  ///
  /// In en, this message translates to:
  /// **'Macro Split'**
  String get goalsMacroSplit;

  /// No description provided for @goalsWeightTarget.
  ///
  /// In en, this message translates to:
  /// **'Weight Target'**
  String get goalsWeightTarget;

  /// No description provided for @goalsCurrentWeight.
  ///
  /// In en, this message translates to:
  /// **'Current Weight'**
  String get goalsCurrentWeight;

  /// No description provided for @goalsProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get goalsProgress;

  /// No description provided for @goalsAchieved.
  ///
  /// In en, this message translates to:
  /// **'Achieved'**
  String get goalsAchieved;

  /// No description provided for @goalsTarget.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get goalsTarget;

  /// No description provided for @goalsDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this goal?'**
  String get goalsDeleteConfirm;

  /// No description provided for @goalsDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this goal? This action cannot be undone.'**
  String get goalsDeleteMessage;

  /// No description provided for @goalsGoalDeleted.
  ///
  /// In en, this message translates to:
  /// **'Goal deleted'**
  String get goalsGoalDeleted;

  /// No description provided for @goalsGoalSaved.
  ///
  /// In en, this message translates to:
  /// **'Goal saved'**
  String get goalsGoalSaved;

  /// No description provided for @bmiTitle.
  ///
  /// In en, this message translates to:
  /// **'BMI Calculator'**
  String get bmiTitle;

  /// No description provided for @bmiDescription.
  ///
  /// In en, this message translates to:
  /// **'Body Mass Index is a simple calculation using your height and weight.'**
  String get bmiDescription;

  /// No description provided for @bmiResult.
  ///
  /// In en, this message translates to:
  /// **'Your BMI'**
  String get bmiResult;

  /// No description provided for @bmiCategory.
  ///
  /// In en, this message translates to:
  /// **'BMI Category'**
  String get bmiCategory;

  /// No description provided for @bmiUnderweight.
  ///
  /// In en, this message translates to:
  /// **'Underweight'**
  String get bmiUnderweight;

  /// No description provided for @bmiNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get bmiNormal;

  /// No description provided for @bmiOverweight.
  ///
  /// In en, this message translates to:
  /// **'Overweight'**
  String get bmiOverweight;

  /// No description provided for @bmiObese.
  ///
  /// In en, this message translates to:
  /// **'Obese'**
  String get bmiObese;

  /// No description provided for @bmiSeverelyObese.
  ///
  /// In en, this message translates to:
  /// **'Severely Obese'**
  String get bmiSeverelyObese;

  /// No description provided for @bmiMorbidlyObese.
  ///
  /// In en, this message translates to:
  /// **'Morbidly Obese'**
  String get bmiMorbidlyObese;

  /// No description provided for @bmiTargetBmi.
  ///
  /// In en, this message translates to:
  /// **'Target BMI'**
  String get bmiTargetBmi;

  /// No description provided for @bmiSetAsGoal.
  ///
  /// In en, this message translates to:
  /// **'Set as Goal'**
  String get bmiSetAsGoal;

  /// No description provided for @bmiUpdated.
  ///
  /// In en, this message translates to:
  /// **'BMI goal updated'**
  String get bmiUpdated;

  /// No description provided for @proteinTitle.
  ///
  /// In en, this message translates to:
  /// **'Protein Intake Calculator'**
  String get proteinTitle;

  /// No description provided for @proteinDescription.
  ///
  /// In en, this message translates to:
  /// **'Calculate your optimal daily protein intake based on your activity level and goals.'**
  String get proteinDescription;

  /// No description provided for @proteinResult.
  ///
  /// In en, this message translates to:
  /// **'Daily Protein Goal'**
  String get proteinResult;

  /// No description provided for @proteinGrams.
  ///
  /// In en, this message translates to:
  /// **'g'**
  String get proteinGrams;

  /// No description provided for @proteinPerDay.
  ///
  /// In en, this message translates to:
  /// **'per day'**
  String get proteinPerDay;

  /// No description provided for @proteinActivitySedentary.
  ///
  /// In en, this message translates to:
  /// **'Sedentary'**
  String get proteinActivitySedentary;

  /// No description provided for @proteinActivityLight.
  ///
  /// In en, this message translates to:
  /// **'Light Exercise'**
  String get proteinActivityLight;

  /// No description provided for @proteinActivityModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate Exercise'**
  String get proteinActivityModerate;

  /// No description provided for @proteinActivityActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get proteinActivityActive;

  /// No description provided for @proteinActivityVeryActive.
  ///
  /// In en, this message translates to:
  /// **'Very Active'**
  String get proteinActivityVeryActive;

  /// No description provided for @proteinGoalMaintain.
  ///
  /// In en, this message translates to:
  /// **'Maintain'**
  String get proteinGoalMaintain;

  /// No description provided for @proteinGoalLose.
  ///
  /// In en, this message translates to:
  /// **'Lose Weight'**
  String get proteinGoalLose;

  /// No description provided for @proteinGoalGain.
  ///
  /// In en, this message translates to:
  /// **'Gain Muscle'**
  String get proteinGoalGain;

  /// No description provided for @proteinSetAsGoal.
  ///
  /// In en, this message translates to:
  /// **'Set as Goal'**
  String get proteinSetAsGoal;

  /// No description provided for @proteinUpdated.
  ///
  /// In en, this message translates to:
  /// **'Protein goal updated'**
  String get proteinUpdated;

  /// No description provided for @calorieTitle.
  ///
  /// In en, this message translates to:
  /// **'Calorie Calculator'**
  String get calorieTitle;

  /// No description provided for @calorieDescription.
  ///
  /// In en, this message translates to:
  /// **'Estimate your daily calorie needs based on your activity level and goals.'**
  String get calorieDescription;

  /// No description provided for @calorieResult.
  ///
  /// In en, this message translates to:
  /// **'Daily Calorie Goal'**
  String get calorieResult;

  /// No description provided for @calorieCalories.
  ///
  /// In en, this message translates to:
  /// **'calories'**
  String get calorieCalories;

  /// No description provided for @caloriePerDay.
  ///
  /// In en, this message translates to:
  /// **'per day'**
  String get caloriePerDay;

  /// No description provided for @calorieBmr.
  ///
  /// In en, this message translates to:
  /// **'BMR'**
  String get calorieBmr;

  /// No description provided for @calorieTdee.
  ///
  /// In en, this message translates to:
  /// **'TDEE'**
  String get calorieTdee;

  /// No description provided for @calorieActivitySedentary.
  ///
  /// In en, this message translates to:
  /// **'Sedentary'**
  String get calorieActivitySedentary;

  /// No description provided for @calorieActivityLight.
  ///
  /// In en, this message translates to:
  /// **'Light Exercise'**
  String get calorieActivityLight;

  /// No description provided for @calorieActivityModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate Exercise'**
  String get calorieActivityModerate;

  /// No description provided for @calorieActivityActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get calorieActivityActive;

  /// No description provided for @calorieActivityVeryActive.
  ///
  /// In en, this message translates to:
  /// **'Very Active'**
  String get calorieActivityVeryActive;

  /// No description provided for @calorieGoalLose.
  ///
  /// In en, this message translates to:
  /// **'Lose Weight'**
  String get calorieGoalLose;

  /// No description provided for @calorieGoalMaintain.
  ///
  /// In en, this message translates to:
  /// **'Maintain'**
  String get calorieGoalMaintain;

  /// No description provided for @calorieGoalGain.
  ///
  /// In en, this message translates to:
  /// **'Gain Weight'**
  String get calorieGoalGain;

  /// No description provided for @calorieDeficit.
  ///
  /// In en, this message translates to:
  /// **'Deficit'**
  String get calorieDeficit;

  /// No description provided for @calorieSurplus.
  ///
  /// In en, this message translates to:
  /// **'Surplus'**
  String get calorieSurplus;

  /// No description provided for @calorieSetAsGoal.
  ///
  /// In en, this message translates to:
  /// **'Set as Goal'**
  String get calorieSetAsGoal;

  /// No description provided for @calorieUpdated.
  ///
  /// In en, this message translates to:
  /// **'Calorie goal updated'**
  String get calorieUpdated;

  /// No description provided for @macroTitle.
  ///
  /// In en, this message translates to:
  /// **'Macro Calculator'**
  String get macroTitle;

  /// No description provided for @macroDescription.
  ///
  /// In en, this message translates to:
  /// **'Calculate your recommended daily macronutrient split based on your calorie goal.'**
  String get macroDescription;

  /// No description provided for @macroProtein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get macroProtein;

  /// No description provided for @macroCarbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get macroCarbs;

  /// No description provided for @macroFat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get macroFat;

  /// No description provided for @macroGrams.
  ///
  /// In en, this message translates to:
  /// **'g'**
  String get macroGrams;

  /// No description provided for @macroCalories.
  ///
  /// In en, this message translates to:
  /// **'cal'**
  String get macroCalories;

  /// No description provided for @macroPercentage.
  ///
  /// In en, this message translates to:
  /// **'%'**
  String get macroPercentage;

  /// No description provided for @macroSplit.
  ///
  /// In en, this message translates to:
  /// **'Macro Split'**
  String get macroSplit;

  /// No description provided for @macroSetAsGoal.
  ///
  /// In en, this message translates to:
  /// **'Set as Goal'**
  String get macroSetAsGoal;

  /// No description provided for @macroUpdated.
  ///
  /// In en, this message translates to:
  /// **'Macro goal updated'**
  String get macroUpdated;

  /// No description provided for @measurementTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Measurement'**
  String get measurementTitle;

  /// No description provided for @measurementWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get measurementWeight;

  /// No description provided for @measurementDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get measurementDate;

  /// No description provided for @measurementNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get measurementNotes;

  /// No description provided for @measurementNotesHint.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling today?'**
  String get measurementNotesHint;

  /// No description provided for @measurementSave.
  ///
  /// In en, this message translates to:
  /// **'Save Measurement'**
  String get measurementSave;

  /// No description provided for @measurementSaved.
  ///
  /// In en, this message translates to:
  /// **'Measurement saved'**
  String get measurementSaved;

  /// No description provided for @measurementDeleted.
  ///
  /// In en, this message translates to:
  /// **'Measurement deleted'**
  String get measurementDeleted;

  /// No description provided for @measurementDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this measurement?'**
  String get measurementDeleteConfirm;

  /// No description provided for @measurementInvalidWeight.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid weight'**
  String get measurementInvalidWeight;

  /// No description provided for @measurementWeightRequired.
  ///
  /// In en, this message translates to:
  /// **'Weight is required'**
  String get measurementWeightRequired;

  /// No description provided for @measurementSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date for this measurement'**
  String get measurementSelectDate;

  /// No description provided for @measurementNoNotes.
  ///
  /// In en, this message translates to:
  /// **'No notes'**
  String get measurementNoNotes;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsLight;

  /// No description provided for @settingsDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsDark;

  /// No description provided for @settingsSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsSystem;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsEnglish;

  /// No description provided for @settingsKurdish.
  ///
  /// In en, this message translates to:
  /// **'Kurdish (Sorani)'**
  String get settingsKurdish;

  /// No description provided for @settingsArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get settingsArabic;

  /// No description provided for @settingsSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get settingsSpanish;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get settingsReminders;

  /// No description provided for @settingsReminderDesc.
  ///
  /// In en, this message translates to:
  /// **'Get reminded to log your measurements'**
  String get settingsReminderDesc;

  /// No description provided for @settingsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get settingsEnabled;

  /// No description provided for @settingsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get settingsDisabled;

  /// No description provided for @settingsDeleteAllData.
  ///
  /// In en, this message translates to:
  /// **'Delete All Data'**
  String get settingsDeleteAllData;

  /// No description provided for @settingsDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete all data?'**
  String get settingsDeleteConfirm;

  /// No description provided for @settingsDeleteWarning.
  ///
  /// In en, this message translates to:
  /// **'This will permanently remove all your measurements and goals. This action cannot be undone.'**
  String get settingsDeleteWarning;

  /// No description provided for @settingsDataDeleted.
  ///
  /// In en, this message translates to:
  /// **'All data has been deleted'**
  String get settingsDataDeleted;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationTitle;

  /// No description provided for @notificationPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get notificationPermissionTitle;

  /// No description provided for @notificationPermissionMessage.
  ///
  /// In en, this message translates to:
  /// **'We\'d like to remind you to track your progress. Enable notifications to receive friendly reminders.'**
  String get notificationPermissionMessage;

  /// No description provided for @notificationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission was denied. You can enable it in your device settings.'**
  String get notificationPermissionDenied;

  /// No description provided for @notificationGoToSettings.
  ///
  /// In en, this message translates to:
  /// **'Go to Settings'**
  String get notificationGoToSettings;

  /// No description provided for @notificationReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget to log your measurements today!'**
  String get notificationReminderBody;

  /// No description provided for @notificationChannelName.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get notificationChannelName;

  /// No description provided for @notificationChannelDesc.
  ///
  /// In en, this message translates to:
  /// **'Measurement reminders'**
  String get notificationChannelDesc;

  /// No description provided for @notificationEnabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications enabled'**
  String get notificationEnabled;

  /// No description provided for @notificationDisabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications disabled'**
  String get notificationDisabled;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'A privacy-first fitness tracking app. All your data stays on your device — no accounts, no cloud, no tracking.'**
  String get aboutDescription;

  /// No description provided for @aboutBuiltWith.
  ///
  /// In en, this message translates to:
  /// **'Built with Flutter'**
  String get aboutBuiltWith;

  /// No description provided for @aboutOpenSource.
  ///
  /// In en, this message translates to:
  /// **'Open Source'**
  String get aboutOpenSource;

  /// Version string with placeholder
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String aboutVersion(String version);

  /// No description provided for @aboutDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get aboutDeveloper;

  /// No description provided for @featuresTitle.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get featuresTitle;

  /// No description provided for @featuresBmiCalculator.
  ///
  /// In en, this message translates to:
  /// **'BMI Calculator'**
  String get featuresBmiCalculator;

  /// No description provided for @featuresBmiDesc.
  ///
  /// In en, this message translates to:
  /// **'Calculate your Body Mass Index and set target BMI goals.'**
  String get featuresBmiDesc;

  /// No description provided for @featuresProteinTracker.
  ///
  /// In en, this message translates to:
  /// **'Protein Intake Tracker'**
  String get featuresProteinTracker;

  /// No description provided for @featuresCalorieTracker.
  ///
  /// In en, this message translates to:
  /// **'Calorie Tracker'**
  String get featuresCalorieTracker;

  /// No description provided for @featuresCalorieDesc.
  ///
  /// In en, this message translates to:
  /// **'Estimate daily calorie needs and track your intake.'**
  String get featuresCalorieDesc;

  /// No description provided for @featuresMacroTracker.
  ///
  /// In en, this message translates to:
  /// **'Macro Tracker'**
  String get featuresMacroTracker;

  /// No description provided for @featuresMacroDesc.
  ///
  /// In en, this message translates to:
  /// **'Track your carbohydrate, protein, and fat intake.'**
  String get featuresMacroDesc;

  /// No description provided for @featuresProgressTracking.
  ///
  /// In en, this message translates to:
  /// **'Progress Tracking'**
  String get featuresProgressTracking;

  /// No description provided for @featuresLocalOnly.
  ///
  /// In en, this message translates to:
  /// **'100% Local'**
  String get featuresLocalOnly;

  /// No description provided for @featuresLocalOnlyDesc.
  ///
  /// In en, this message translates to:
  /// **'All data stored on your device — no account needed.'**
  String get featuresLocalOnlyDesc;

  /// No description provided for @featuresNotifications.
  ///
  /// In en, this message translates to:
  /// **'Smart Reminders'**
  String get featuresNotifications;

  /// No description provided for @featuresNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Optional reminders to help you stay consistent.'**
  String get featuresNotificationsDesc;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpTitle;

  /// No description provided for @helpFaq.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get helpFaq;

  /// No description provided for @helpFaq1Q.
  ///
  /// In en, this message translates to:
  /// **'How is my data stored?'**
  String get helpFaq1Q;

  /// No description provided for @helpFaq1A.
  ///
  /// In en, this message translates to:
  /// **'All your data is stored locally on your device using secure local storage. No data is ever sent to external servers or third parties.'**
  String get helpFaq1A;

  /// No description provided for @helpFaq2Q.
  ///
  /// In en, this message translates to:
  /// **'Can I export my data?'**
  String get helpFaq2Q;

  /// No description provided for @helpFaq2A.
  ///
  /// In en, this message translates to:
  /// **'Data export is not currently available. Your data remains securely on your device.'**
  String get helpFaq2A;

  /// No description provided for @helpFaq3Q.
  ///
  /// In en, this message translates to:
  /// **'How do I reset my data?'**
  String get helpFaq3Q;

  /// No description provided for @helpFaq3A.
  ///
  /// In en, this message translates to:
  /// **'Go to Settings and select \'Delete All Data\'. This will remove all your measurements and goals permanently.'**
  String get helpFaq3A;

  /// No description provided for @helpFaq4Q.
  ///
  /// In en, this message translates to:
  /// **'How do notifications work?'**
  String get helpFaq4Q;

  /// No description provided for @helpFaq4A.
  ///
  /// In en, this message translates to:
  /// **'Optional reminders can be enabled in Settings. Notifications are scheduled locally on your device and are not sent over the internet.'**
  String get helpFaq4A;

  /// No description provided for @helpFaq5Q.
  ///
  /// In en, this message translates to:
  /// **'Is an account required?'**
  String get helpFaq5Q;

  /// No description provided for @helpFaq5A.
  ///
  /// In en, this message translates to:
  /// **'No. FitTracker works completely offline with no account. Simply open the app and start tracking.'**
  String get helpFaq5A;

  /// No description provided for @helpFaq6Q.
  ///
  /// In en, this message translates to:
  /// **'How do I change my weight unit?'**
  String get helpFaq6Q;

  /// No description provided for @helpFaq6A.
  ///
  /// In en, this message translates to:
  /// **'Weight units are displayed in kilograms (kg) based on your input. Unit conversion is planned for a future update.'**
  String get helpFaq6A;

  /// No description provided for @helpContact.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get helpContact;

  /// No description provided for @helpContactDesc.
  ///
  /// In en, this message translates to:
  /// **'Have a question or issue? Reach out to us:'**
  String get helpContactDesc;

  /// No description provided for @helpContactEmail.
  ///
  /// In en, this message translates to:
  /// **'support@fittracker.app'**
  String get helpContactEmail;

  /// No description provided for @helpNoSupport.
  ///
  /// In en, this message translates to:
  /// **'This is a local-only app. For support, please refer to the FAQ above.'**
  String get helpNoSupport;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyTitle;

  /// No description provided for @privacyLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated: July 2026'**
  String get privacyLastUpdated;

  /// No description provided for @privacyIntro.
  ///
  /// In en, this message translates to:
  /// **'Your privacy is our priority. FitTracker is designed to work entirely on your device with no data collection.'**
  String get privacyIntro;

  /// No description provided for @privacySection1Title.
  ///
  /// In en, this message translates to:
  /// **'1. Information We Collect'**
  String get privacySection1Title;

  /// No description provided for @privacySection1Body.
  ///
  /// In en, this message translates to:
  /// **'FitTracker does not collect, store, or transmit any personal information. All data you enter — including weight, height, age, goals, and measurements — is stored locally on your device only.'**
  String get privacySection1Body;

  /// No description provided for @privacySection2Title.
  ///
  /// In en, this message translates to:
  /// **'2. How We Use Your Data'**
  String get privacySection2Title;

  /// No description provided for @privacySection2Body.
  ///
  /// In en, this message translates to:
  /// **'Your data is used exclusively to provide in-app functionality:\n\n- Display your measurements and progress\n- Calculate BMI, calorie needs, and macro splits\n- Track your goals over time\n\nNo data is processed on external servers.'**
  String get privacySection2Body;

  /// No description provided for @privacySection3Title.
  ///
  /// In en, this message translates to:
  /// **'3. Data Storage'**
  String get privacySection3Title;

  /// No description provided for @privacySection3Body.
  ///
  /// In en, this message translates to:
  /// **'All data is stored locally using Hive and flutter_secure_storage. Data persists only on your device and is removed when you delete the app or use the \'Delete All Data\' option in Settings.'**
  String get privacySection3Body;

  /// No description provided for @privacySection4Title.
  ///
  /// In en, this message translates to:
  /// **'4. Third-Party Services'**
  String get privacySection4Title;

  /// No description provided for @privacySection4Body.
  ///
  /// In en, this message translates to:
  /// **'FitTracker does not integrate any third-party analytics, advertising, or tracking services. The app functions fully offline.'**
  String get privacySection4Body;

  /// No description provided for @privacySection5Title.
  ///
  /// In en, this message translates to:
  /// **'5. Notifications'**
  String get privacySection5Title;

  /// No description provided for @privacySection5Body.
  ///
  /// In en, this message translates to:
  /// **'If enabled, notifications are scheduled locally on your device. No notification data is sent externally.'**
  String get privacySection5Body;

  /// No description provided for @privacySection6Title.
  ///
  /// In en, this message translates to:
  /// **'6. Children\'s Privacy'**
  String get privacySection6Title;

  /// No description provided for @privacySection6Body.
  ///
  /// In en, this message translates to:
  /// **'FitTracker does not knowingly collect any data from children. Since no data is collected at all, children can use the app safely.'**
  String get privacySection6Body;

  /// No description provided for @privacySection7Title.
  ///
  /// In en, this message translates to:
  /// **'7. Changes to This Policy'**
  String get privacySection7Title;

  /// No description provided for @privacySection7Body.
  ///
  /// In en, this message translates to:
  /// **'Any changes to this privacy policy will be reflected in the app. Since the app operates offline, you will be notified of changes in the next update.'**
  String get privacySection7Body;

  /// No description provided for @privacySection8Title.
  ///
  /// In en, this message translates to:
  /// **'8. Contact'**
  String get privacySection8Title;

  /// No description provided for @privacySection8Body.
  ///
  /// In en, this message translates to:
  /// **'If you have questions about this privacy policy, please contact us at support@fittracker.app.'**
  String get privacySection8Body;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsTitle;

  /// No description provided for @termsLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated: July 2026'**
  String get termsLastUpdated;

  /// No description provided for @termsIntro.
  ///
  /// In en, this message translates to:
  /// **'By using FitTracker, you agree to the following terms and conditions.'**
  String get termsIntro;

  /// No description provided for @termsSection1Title.
  ///
  /// In en, this message translates to:
  /// **'1. Acceptance of Terms'**
  String get termsSection1Title;

  /// No description provided for @termsSection1Body.
  ///
  /// In en, this message translates to:
  /// **'By downloading, installing, or using FitTracker, you agree to be bound by these terms. If you do not agree, please do not use the app.'**
  String get termsSection1Body;

  /// No description provided for @termsSection2Title.
  ///
  /// In en, this message translates to:
  /// **'2. Use of the App'**
  String get termsSection2Title;

  /// No description provided for @termsSection2Body.
  ///
  /// In en, this message translates to:
  /// **'FitTracker is provided for personal, non-commercial use. You agree not to:\n\n- Modify, reverse-engineer, or distribute the app\n- Use the app for any unlawful purpose\n- Attempt to extract data from other users (the app has no network features)'**
  String get termsSection2Body;

  /// No description provided for @termsSection3Title.
  ///
  /// In en, this message translates to:
  /// **'3. Data Responsibility'**
  String get termsSection3Title;

  /// No description provided for @termsSection3Body.
  ///
  /// In en, this message translates to:
  /// **'You are solely responsible for the data you enter into the app. The developers are not responsible for data loss. Regular backups are recommended through your device\'s backup system.'**
  String get termsSection3Body;

  /// No description provided for @termsSection4Title.
  ///
  /// In en, this message translates to:
  /// **'4. Disclaimer'**
  String get termsSection4Title;

  /// No description provided for @termsSection4Body.
  ///
  /// In en, this message translates to:
  /// **'FitTracker is provided \'as is\' without warranty of any kind. The developers are not liable for any damages arising from the use of this app. Health and fitness information provided is for reference only and is not medical advice.'**
  String get termsSection4Body;

  /// No description provided for @termsSection5Title.
  ///
  /// In en, this message translates to:
  /// **'5. Limitation of Liability'**
  String get termsSection5Title;

  /// No description provided for @termsSection5Body.
  ///
  /// In en, this message translates to:
  /// **'In no event shall the developers be liable for any indirect, incidental, or consequential damages arising from your use of the app.'**
  String get termsSection5Body;

  /// No description provided for @termsSection6Title.
  ///
  /// In en, this message translates to:
  /// **'6. Changes to Terms'**
  String get termsSection6Title;

  /// No description provided for @termsSection6Body.
  ///
  /// In en, this message translates to:
  /// **'We reserve the right to update these terms at any time. Continued use of the app after changes constitutes acceptance of the new terms.'**
  String get termsSection6Body;

  /// No description provided for @termsSection7Title.
  ///
  /// In en, this message translates to:
  /// **'7. Governing Law'**
  String get termsSection7Title;

  /// No description provided for @termsSection7Body.
  ///
  /// In en, this message translates to:
  /// **'These terms shall be governed by the laws of the Kurdistan Region of Iraq.'**
  String get termsSection7Body;

  /// No description provided for @weightChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Weight Trend'**
  String get weightChartTitle;

  /// No description provided for @weightChartNoData.
  ///
  /// In en, this message translates to:
  /// **'Not enough data to show a chart'**
  String get weightChartNoData;

  /// No description provided for @weightChartNeedMore.
  ///
  /// In en, this message translates to:
  /// **'Log at least 2 measurements to see your weight trend'**
  String get weightChartNeedMore;

  /// No description provided for @weightChartToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get weightChartToday;

  /// No description provided for @weightChartKgLabel.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get weightChartKgLabel;

  /// No description provided for @weightChartKgValue.
  ///
  /// In en, this message translates to:
  /// **'{value} kg'**
  String weightChartKgValue(String value);

  /// No description provided for @weightChartDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get weightChartDateLabel;

  /// No description provided for @guestLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get guestLoginTitle;

  /// No description provided for @guestLoginDesc.
  ///
  /// In en, this message translates to:
  /// **'No account needed. Your data stays on this device only.'**
  String get guestLoginDesc;

  /// No description provided for @guestLoginButton.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get guestLoginButton;

  /// No description provided for @authLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get authLoginTitle;

  /// No description provided for @authLoginDesc.
  ///
  /// In en, this message translates to:
  /// **'Track your fitness journey, your way.'**
  String get authLoginDesc;

  /// No description provided for @macroGPerDay.
  ///
  /// In en, this message translates to:
  /// **'g/day'**
  String get macroGPerDay;

  /// No description provided for @macroCalPerDay.
  ///
  /// In en, this message translates to:
  /// **'cal/day'**
  String get macroCalPerDay;

  /// No description provided for @macroOfCalories.
  ///
  /// In en, this message translates to:
  /// **'of calories'**
  String get macroOfCalories;

  /// No description provided for @macroRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get macroRecommended;

  /// No description provided for @macroCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get macroCustom;

  /// No description provided for @macroRatio.
  ///
  /// In en, this message translates to:
  /// **'Ratio'**
  String get macroRatio;

  /// No description provided for @proteinGPerDay.
  ///
  /// In en, this message translates to:
  /// **'g/day'**
  String get proteinGPerDay;

  /// No description provided for @proteinIntake.
  ///
  /// In en, this message translates to:
  /// **'Intake'**
  String get proteinIntake;

  /// No description provided for @proteinActivityLevel.
  ///
  /// In en, this message translates to:
  /// **'Activity Level'**
  String get proteinActivityLevel;

  /// No description provided for @proteinGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get proteinGoal;

  /// No description provided for @calorieCaloriesPerDay.
  ///
  /// In en, this message translates to:
  /// **'calories/day'**
  String get calorieCaloriesPerDay;

  /// No description provided for @calorieActivityLevel.
  ///
  /// In en, this message translates to:
  /// **'Activity Level'**
  String get calorieActivityLevel;

  /// No description provided for @calorieGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get calorieGoal;

  /// No description provided for @calorieMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get calorieMaintenance;

  /// BMI value display
  ///
  /// In en, this message translates to:
  /// **'BMI: {value}'**
  String bmiValue(String value);

  /// No description provided for @bmiSetGoalConfirm.
  ///
  /// In en, this message translates to:
  /// **'Set target BMI to {value}?'**
  String bmiSetGoalConfirm(String value);

  /// No description provided for @proteinSetGoalConfirm.
  ///
  /// In en, this message translates to:
  /// **'Set daily protein goal to {value}g?'**
  String proteinSetGoalConfirm(String value);

  /// No description provided for @calorieSetGoalConfirm.
  ///
  /// In en, this message translates to:
  /// **'Set daily calorie goal to {value} cal?'**
  String calorieSetGoalConfirm(String value);

  /// No description provided for @macroSetGoalConfirm.
  ///
  /// In en, this message translates to:
  /// **'Set macro split as goal?'**
  String get macroSetGoalConfirm;

  /// No description provided for @macroCarbsRatio.
  ///
  /// In en, this message translates to:
  /// **'Carbs: {value}%'**
  String macroCarbsRatio(String value);

  /// No description provided for @macroProteinRatio.
  ///
  /// In en, this message translates to:
  /// **'Protein: {value}%'**
  String macroProteinRatio(String value);

  /// No description provided for @macroFatRatio.
  ///
  /// In en, this message translates to:
  /// **'Fat: {value}%'**
  String macroFatRatio(String value);

  /// No description provided for @homeWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight: {value} kg'**
  String homeWeightLabel(String value);

  /// No description provided for @homeGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Goal: {value} kg'**
  String homeGoalLabel(String value);

  /// No description provided for @homeCalculatorsLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} calculators'**
  String homeCalculatorsLabel(String count);

  /// No description provided for @progressWeightValue.
  ///
  /// In en, this message translates to:
  /// **'{value} kg'**
  String progressWeightValue(String value);

  /// No description provided for @progressBmi.
  ///
  /// In en, this message translates to:
  /// **'BMI'**
  String get progressBmi;

  /// No description provided for @progressGoalForValue.
  ///
  /// In en, this message translates to:
  /// **'Goal for {value}'**
  String progressGoalForValue(String value);

  /// No description provided for @goalsProgressValue.
  ///
  /// In en, this message translates to:
  /// **'{current} / {target} {unit}'**
  String goalsProgressValue(String current, String target, String unit);

  /// No description provided for @measurementDateSelected.
  ///
  /// In en, this message translates to:
  /// **'Date: {date}'**
  String measurementDateSelected(String date);

  /// No description provided for @notificationBodyWithName.
  ///
  /// In en, this message translates to:
  /// **'Hey {name}, don\'t forget to log your measurements today!'**
  String notificationBodyWithName(String name);

  /// No description provided for @settingsLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language: {language}'**
  String settingsLanguageLabel(String language);

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get settingsMore;

  /// No description provided for @settingsProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get settingsProfile;

  /// No description provided for @settingsEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get settingsEditProfile;

  /// No description provided for @settingsEditProfileSub.
  ///
  /// In en, this message translates to:
  /// **'Update your information'**
  String get settingsEditProfileSub;

  /// No description provided for @settingsPrivacyPolicySub.
  ///
  /// In en, this message translates to:
  /// **'Read our privacy terms'**
  String get settingsPrivacyPolicySub;

  /// No description provided for @settingsTermsSub.
  ///
  /// In en, this message translates to:
  /// **'Read our terms'**
  String get settingsTermsSub;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settingsDeleteAccount;

  /// No description provided for @settingsDeleteAccountSub.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your account'**
  String get settingsDeleteAccountSub;

  /// No description provided for @settingsToggleTheme.
  ///
  /// In en, this message translates to:
  /// **'Toggle dark/light theme'**
  String get settingsToggleTheme;

  /// No description provided for @settingsDeleteAccountConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get settingsDeleteAccountConfirm;

  /// No description provided for @settingsDeleteAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get settingsDeleteAccountWarning;

  /// No description provided for @authWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get authWelcomeBack;

  /// No description provided for @authTrackJourney.
  ///
  /// In en, this message translates to:
  /// **'Track your fitness journey'**
  String get authTrackJourney;

  /// No description provided for @authLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get authLogin;

  /// No description provided for @authDontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get authDontHaveAccount;

  /// No description provided for @authRegister.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get authRegister;

  /// No description provided for @authRegisterTitle.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get authRegisterTitle;

  /// No description provided for @authLetsGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get started!'**
  String get authLetsGetStarted;

  /// No description provided for @authCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get authCreateAccount;

  /// No description provided for @authAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get authAlreadyHaveAccount;

  /// No description provided for @onboardingProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Watch Your\nProgress Soar'**
  String get onboardingProgressTitle;

  /// No description provided for @onboardingProgressDesc.
  ///
  /// In en, this message translates to:
  /// **'Log daily weight measurements and visualize your transformation over time with elegant charts.'**
  String get onboardingProgressDesc;

  /// No description provided for @onboardingGoalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Goals,\nStay Motivated'**
  String get onboardingGoalsTitle;

  /// No description provided for @onboardingGoalsDesc.
  ///
  /// In en, this message translates to:
  /// **'Define weight, protein, and calorie targets. Track completion and celebrate every milestone.'**
  String get onboardingGoalsDesc;

  /// No description provided for @onboardingCalculatorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart Fitness\nCalculators'**
  String get onboardingCalculatorsTitle;

  /// No description provided for @onboardingCalculatorsDesc.
  ///
  /// In en, this message translates to:
  /// **'Ideal body weight, daily calories, protein intake — science-backed tools right at your fingertips.'**
  String get onboardingCalculatorsDesc;

  /// No description provided for @onboardingPersonalizedTitle.
  ///
  /// In en, this message translates to:
  /// **'Tailored Just\nFor You'**
  String get onboardingPersonalizedTitle;

  /// No description provided for @profileUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get profileUpdateTitle;

  /// No description provided for @profileUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get profileUsername;

  /// No description provided for @profileWeightKg.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get profileWeightKg;

  /// No description provided for @profileHeightCm.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get profileHeightCm;

  /// No description provided for @profileSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get profileSaveChanges;

  /// No description provided for @validatorUsernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Username is required'**
  String get validatorUsernameRequired;

  /// No description provided for @validatorUsernameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Username must be at least 3 characters'**
  String get validatorUsernameMinLength;

  /// No description provided for @validatorUsernameReserved.
  ///
  /// In en, this message translates to:
  /// **'This username is reserved'**
  String get validatorUsernameReserved;

  /// No description provided for @validatorUsernameChars.
  ///
  /// In en, this message translates to:
  /// **'Username can only contain letters, numbers, ., _, and -'**
  String get validatorUsernameChars;

  /// No description provided for @validatorAgeRequired.
  ///
  /// In en, this message translates to:
  /// **'Age is required'**
  String get validatorAgeRequired;

  /// No description provided for @validatorValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get validatorValidNumber;

  /// No description provided for @validatorAgeMin.
  ///
  /// In en, this message translates to:
  /// **'Must be at least 13 years old'**
  String get validatorAgeMin;

  /// No description provided for @validatorAgeValid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid age'**
  String get validatorAgeValid;

  /// No description provided for @validatorWeightRequired.
  ///
  /// In en, this message translates to:
  /// **'Weight is required'**
  String get validatorWeightRequired;

  /// No description provided for @validatorWeightRange.
  ///
  /// In en, this message translates to:
  /// **'Weight must be between 1-300 kg'**
  String get validatorWeightRange;

  /// No description provided for @validatorPasskeyRequired.
  ///
  /// In en, this message translates to:
  /// **'Passkey is required'**
  String get validatorPasskeyRequired;

  /// No description provided for @validatorPasskeyMinLength.
  ///
  /// In en, this message translates to:
  /// **'Must be at least 6 characters'**
  String get validatorPasskeyMinLength;

  /// No description provided for @validatorPasskeyMaxLength.
  ///
  /// In en, this message translates to:
  /// **'Must be at most 64 characters'**
  String get validatorPasskeyMaxLength;

  /// No description provided for @validatorPasskeyChars.
  ///
  /// In en, this message translates to:
  /// **'Only letters, numbers, and common symbols allowed'**
  String get validatorPasskeyChars;

  /// No description provided for @validatorHeightRequired.
  ///
  /// In en, this message translates to:
  /// **'Height is required'**
  String get validatorHeightRequired;

  /// No description provided for @validatorHeightRange.
  ///
  /// In en, this message translates to:
  /// **'Height must be between 1-300 cm'**
  String get validatorHeightRange;

  /// No description provided for @errorTooManyAttempts.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Try again in {seconds}s'**
  String errorTooManyAttempts(String seconds);

  /// No description provided for @errorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid username or passkey ({count} attempt(s) remaining)'**
  String errorInvalidCredentials(String count);

  /// No description provided for @errorLockedOut.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Locked out for {seconds}s'**
  String errorLockedOut(String seconds);

  /// No description provided for @errorLoginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get errorLoginFailed;

  /// No description provided for @errorGuestSessionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to start guest session'**
  String get errorGuestSessionFailed;

  /// No description provided for @errorUsernameTaken.
  ///
  /// In en, this message translates to:
  /// **'Username already taken'**
  String get errorUsernameTaken;

  /// No description provided for @errorRegistrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get errorRegistrationFailed;

  /// No description provided for @errorNotificationBlocked.
  ///
  /// In en, this message translates to:
  /// **'Notification permission is blocked.'**
  String get errorNotificationBlocked;

  /// No description provided for @errorNotificationDenied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission was not granted.'**
  String get errorNotificationDenied;

  /// No description provided for @errorNotificationSchedule.
  ///
  /// In en, this message translates to:
  /// **'Unable to schedule notifications on this device.'**
  String get errorNotificationSchedule;

  /// No description provided for @errorNotificationUpdate.
  ///
  /// In en, this message translates to:
  /// **'Failed to update notifications.'**
  String get errorNotificationUpdate;

  /// No description provided for @errorNoUserLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'No user logged in'**
  String get errorNoUserLoggedIn;

  /// No description provided for @errorProfileUpdate.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile'**
  String get errorProfileUpdate;

  /// No description provided for @successReminderScheduled.
  ///
  /// In en, this message translates to:
  /// **'Weight reminder scheduled every three days.'**
  String get successReminderScheduled;

  /// No description provided for @successNotificationsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications disabled.'**
  String get successNotificationsDisabled;

  /// No description provided for @successProfileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get successProfileUpdated;

  /// No description provided for @goalsDescriptionWeight.
  ///
  /// In en, this message translates to:
  /// **'Track your weight goals'**
  String get goalsDescriptionWeight;

  /// No description provided for @goalsDescriptionProtein.
  ///
  /// In en, this message translates to:
  /// **'Daily protein intake target'**
  String get goalsDescriptionProtein;

  /// No description provided for @goalsDescriptionCalorie.
  ///
  /// In en, this message translates to:
  /// **'Daily calorie intake target'**
  String get goalsDescriptionCalorie;

  /// No description provided for @featureDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover Our Features'**
  String get featureDiscover;

  /// No description provided for @featureCount.
  ///
  /// In en, this message translates to:
  /// **'{count}+ tools and capabilities to power your fitness journey.'**
  String featureCount(String count);

  /// No description provided for @nutritionTitle.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get nutritionTitle;

  /// No description provided for @nutritionSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search foods...'**
  String get nutritionSearchHint;

  /// No description provided for @nutritionScanBarcode.
  ///
  /// In en, this message translates to:
  /// **'Scan Barcode'**
  String get nutritionScanBarcode;

  /// No description provided for @nutritionNoFoods.
  ///
  /// In en, this message translates to:
  /// **'No food items found'**
  String get nutritionNoFoods;

  /// No description provided for @nutritionCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get nutritionCalories;

  /// No description provided for @nutritionProtein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get nutritionProtein;

  /// No description provided for @nutritionCarbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get nutritionCarbs;

  /// No description provided for @nutritionFat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get nutritionFat;

  /// No description provided for @nutritionActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get nutritionActions;

  /// No description provided for @nutritionAddFood.
  ///
  /// In en, this message translates to:
  /// **'Add Food Item'**
  String get nutritionAddFood;

  /// No description provided for @nutritionFoodName.
  ///
  /// In en, this message translates to:
  /// **'Food Name'**
  String get nutritionFoodName;

  /// No description provided for @nutritionCaloriesLabel.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get nutritionCaloriesLabel;

  /// No description provided for @nutritionProteinG.
  ///
  /// In en, this message translates to:
  /// **'Protein (g)'**
  String get nutritionProteinG;

  /// No description provided for @nutritionCarbsG.
  ///
  /// In en, this message translates to:
  /// **'Carbs (g)'**
  String get nutritionCarbsG;

  /// No description provided for @nutritionFatG.
  ///
  /// In en, this message translates to:
  /// **'Fat (g)'**
  String get nutritionFatG;

  /// No description provided for @nutritionAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get nutritionAdd;

  /// No description provided for @barcodeScan.
  ///
  /// In en, this message translates to:
  /// **'Scan a barcode'**
  String get barcodeScan;

  /// No description provided for @barcodeFlashlight.
  ///
  /// In en, this message translates to:
  /// **'Flashlight'**
  String get barcodeFlashlight;

  /// No description provided for @barcodeNoDetected.
  ///
  /// In en, this message translates to:
  /// **'No barcode detected'**
  String get barcodeNoDetected;

  /// No description provided for @barcodeFlashlightUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Flashlight unavailable'**
  String get barcodeFlashlightUnavailable;

  /// No description provided for @barcodeNoScanner.
  ///
  /// In en, this message translates to:
  /// **'No barcode scanner available'**
  String get barcodeNoScanner;

  /// No description provided for @barcodeScanFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to scan barcode'**
  String get barcodeScanFailed;

  /// No description provided for @workoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get workoutTitle;

  /// No description provided for @workoutSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search exercises...'**
  String get workoutSearchHint;

  /// No description provided for @workoutNoExercises.
  ///
  /// In en, this message translates to:
  /// **'No exercises found'**
  String get workoutNoExercises;

  /// No description provided for @changePasskeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Passkey'**
  String get changePasskeyTitle;

  /// No description provided for @changePasskeyCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current Passkey'**
  String get changePasskeyCurrent;

  /// No description provided for @changePasskeyNew.
  ///
  /// In en, this message translates to:
  /// **'New Passkey'**
  String get changePasskeyNew;

  /// No description provided for @changePasskeyConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Passkey'**
  String get changePasskeyConfirm;

  /// No description provided for @changePasskeyNoMatch.
  ///
  /// In en, this message translates to:
  /// **'Passkeys do not match'**
  String get changePasskeyNoMatch;

  /// No description provided for @changePasskeyUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update Passkey'**
  String get changePasskeyUpdate;

  /// No description provided for @changePasskeySame.
  ///
  /// In en, this message translates to:
  /// **'Passkey cannot be the same as the old one'**
  String get changePasskeySame;

  /// No description provided for @helpHowCanWeHelp.
  ///
  /// In en, this message translates to:
  /// **'How can we help you?'**
  String get helpHowCanWeHelp;

  /// No description provided for @helpIntro.
  ///
  /// In en, this message translates to:
  /// **'Find answers, troubleshooting tips, and guides to get the most out of Fitness Tracker.'**
  String get helpIntro;

  /// No description provided for @helpQuickNavigation.
  ///
  /// In en, this message translates to:
  /// **'Quick Navigation'**
  String get helpQuickNavigation;

  /// No description provided for @helpTroubleshoot.
  ///
  /// In en, this message translates to:
  /// **'Troubleshoot'**
  String get helpTroubleshoot;

  /// No description provided for @helpTips.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get helpTips;

  /// No description provided for @helpFaqSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Answers to the most common questions.'**
  String get helpFaqSubtitle;

  /// No description provided for @helpTroubleshootingTitle.
  ///
  /// In en, this message translates to:
  /// **'Troubleshooting'**
  String get helpTroubleshootingTitle;

  /// No description provided for @helpTroubleshootingSub.
  ///
  /// In en, this message translates to:
  /// **'Solutions for common issues.'**
  String get helpTroubleshootingSub;

  /// No description provided for @helpTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Tips & Tricks'**
  String get helpTipsTitle;

  /// No description provided for @helpTipsSub.
  ///
  /// In en, this message translates to:
  /// **'Get the most out of your fitness journey.'**
  String get helpTipsSub;

  /// No description provided for @helpSolutions.
  ///
  /// In en, this message translates to:
  /// **'Solutions:'**
  String get helpSolutions;

  /// No description provided for @helpTroubleCalculators.
  ///
  /// In en, this message translates to:
  /// **'Calculators not updating results'**
  String get helpTroubleCalculators;

  /// No description provided for @helpTroubleCalculatorsS1.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Calculate\" after changing any input value'**
  String get helpTroubleCalculatorsS1;

  /// No description provided for @helpTroubleCalculatorsS2.
  ///
  /// In en, this message translates to:
  /// **'Ensure all fields are filled in correctly'**
  String get helpTroubleCalculatorsS2;

  /// No description provided for @helpTroubleCalculatorsS3.
  ///
  /// In en, this message translates to:
  /// **'Restart the app and try again'**
  String get helpTroubleCalculatorsS3;

  /// No description provided for @helpTroubleGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals not showing on dashboard'**
  String get helpTroubleGoals;

  /// No description provided for @helpTroubleGoalsS1.
  ///
  /// In en, this message translates to:
  /// **'Make sure you have set at least one goal in Profile > My Goals'**
  String get helpTroubleGoalsS1;

  /// No description provided for @helpTroubleGoalsS2.
  ///
  /// In en, this message translates to:
  /// **'Pull down on the Home page to refresh'**
  String get helpTroubleGoalsS2;

  /// No description provided for @helpTroubleGoalsS3.
  ///
  /// In en, this message translates to:
  /// **'Check that goal values are realistic (non-zero)'**
  String get helpTroubleGoalsS3;

  /// No description provided for @helpTroubleDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode toggle not working'**
  String get helpTroubleDarkMode;

  /// No description provided for @helpTroubleDarkModeS1.
  ///
  /// In en, this message translates to:
  /// **'Restart the app after toggling'**
  String get helpTroubleDarkModeS1;

  /// No description provided for @helpTroubleDarkModeS2.
  ///
  /// In en, this message translates to:
  /// **'Check your device system settings'**
  String get helpTroubleDarkModeS2;

  /// No description provided for @helpTroubleDarkModeS3.
  ///
  /// In en, this message translates to:
  /// **'Update to the latest app version'**
  String get helpTroubleDarkModeS3;

  /// No description provided for @helpTroubleChart.
  ///
  /// In en, this message translates to:
  /// **'Progress chart not displaying'**
  String get helpTroubleChart;

  /// No description provided for @helpTroubleChartS1.
  ///
  /// In en, this message translates to:
  /// **'Log at least two weight measurements'**
  String get helpTroubleChartS1;

  /// No description provided for @helpTroubleChartS2.
  ///
  /// In en, this message translates to:
  /// **'Ensure measurements are saved successfully'**
  String get helpTroubleChartS2;

  /// No description provided for @helpTroubleChartS3.
  ///
  /// In en, this message translates to:
  /// **'Pull down to refresh the Progress page'**
  String get helpTroubleChartS3;

  /// No description provided for @helpTroubleSlow.
  ///
  /// In en, this message translates to:
  /// **'App feels slow or unresponsive'**
  String get helpTroubleSlow;

  /// No description provided for @helpTroubleSlowS1.
  ///
  /// In en, this message translates to:
  /// **'Close background apps to free memory'**
  String get helpTroubleSlowS1;

  /// No description provided for @helpTroubleSlowS2.
  ///
  /// In en, this message translates to:
  /// **'Clear app cache in device settings'**
  String get helpTroubleSlowS2;

  /// No description provided for @helpTroubleSlowS3.
  ///
  /// In en, this message translates to:
  /// **'Restart your device'**
  String get helpTroubleSlowS3;

  /// No description provided for @helpTipRealistic.
  ///
  /// In en, this message translates to:
  /// **'Set Realistic Goals'**
  String get helpTipRealistic;

  /// No description provided for @helpTipRealisticDesc.
  ///
  /// In en, this message translates to:
  /// **'Aim for 0.5–1 kg change per week for sustainable results.'**
  String get helpTipRealisticDesc;

  /// No description provided for @helpTipConsistent.
  ///
  /// In en, this message translates to:
  /// **'Consistent Updates'**
  String get helpTipConsistent;

  /// No description provided for @helpTipConsistentDesc.
  ///
  /// In en, this message translates to:
  /// **'Weigh yourself on the same day and time each week for accurate trends.'**
  String get helpTipConsistentDesc;

  /// No description provided for @helpTipCalculators.
  ///
  /// In en, this message translates to:
  /// **'Use All Calculators'**
  String get helpTipCalculators;

  /// No description provided for @helpTipCalculatorsDesc.
  ///
  /// In en, this message translates to:
  /// **'Combine calorie, protein, and ideal weight calculators for a complete plan.'**
  String get helpTipCalculatorsDesc;

  /// No description provided for @helpTipDashboard.
  ///
  /// In en, this message translates to:
  /// **'Check Dashboard Daily'**
  String get helpTipDashboard;

  /// No description provided for @helpTipDashboardDesc.
  ///
  /// In en, this message translates to:
  /// **'Your home dashboard shows everything — check it daily to stay on track.'**
  String get helpTipDashboardDesc;

  /// No description provided for @helpTipDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode at Night'**
  String get helpTipDarkMode;

  /// No description provided for @helpTipDarkModeDesc.
  ///
  /// In en, this message translates to:
  /// **'Enable Dark Mode during evening hours to reduce eye strain.'**
  String get helpTipDarkModeDesc;

  /// No description provided for @helpTipNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get helpTipNotifications;

  /// No description provided for @helpTipNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Turn on reminders to stay consistent with your measurement updates.'**
  String get helpTipNotificationsDesc;

  /// No description provided for @helpTipBodybuilder.
  ///
  /// In en, this message translates to:
  /// **'Update Bodybuilder Status'**
  String get helpTipBodybuilder;

  /// No description provided for @helpTipBodybuilderDesc.
  ///
  /// In en, this message translates to:
  /// **'Set your bodybuilder status in profile for more accurate protein calculations.'**
  String get helpTipBodybuilderDesc;

  /// No description provided for @helpTipReview.
  ///
  /// In en, this message translates to:
  /// **'Review Progress Weekly'**
  String get helpTipReview;

  /// No description provided for @helpTipReviewDesc.
  ///
  /// In en, this message translates to:
  /// **'Check your progress chart every week to stay motivated and adjust goals.'**
  String get helpTipReviewDesc;

  /// No description provided for @featuresWhyUseful.
  ///
  /// In en, this message translates to:
  /// **'Why it\'s useful:'**
  String get featuresWhyUseful;

  /// No description provided for @featuresNeedHelp.
  ///
  /// In en, this message translates to:
  /// **'Need Help?'**
  String get featuresNeedHelp;

  /// No description provided for @featuresHelpDesc.
  ///
  /// In en, this message translates to:
  /// **'Visit Help & Support for FAQs and troubleshooting.'**
  String get featuresHelpDesc;

  /// No description provided for @featuresDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Home Dashboard'**
  String get featuresDashboardTitle;

  /// No description provided for @featuresDashboardDesc.
  ///
  /// In en, this message translates to:
  /// **'A centralized dashboard showing your key stats, goals progress, recent measurements, and quick actions at a glance.'**
  String get featuresDashboardDesc;

  /// No description provided for @featuresDashboardBenefit1.
  ///
  /// In en, this message translates to:
  /// **'View all key metrics in one place'**
  String get featuresDashboardBenefit1;

  /// No description provided for @featuresDashboardBenefit2.
  ///
  /// In en, this message translates to:
  /// **'Quick access to weight updates'**
  String get featuresDashboardBenefit2;

  /// No description provided for @featuresDashboardBenefit3.
  ///
  /// In en, this message translates to:
  /// **'See goal progress at a glance'**
  String get featuresDashboardBenefit3;

  /// No description provided for @featuresIdealWeightTitle.
  ///
  /// In en, this message translates to:
  /// **'Ideal Body Weight Calculator'**
  String get featuresIdealWeightTitle;

  /// No description provided for @featuresIdealWeightDesc.
  ///
  /// In en, this message translates to:
  /// **'Calculate your ideal body weight based on height and gender using the Devine formula.'**
  String get featuresIdealWeightDesc;

  /// No description provided for @featuresIdealWeightBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Know your ideal weight target'**
  String get featuresIdealWeightBenefit1;

  /// No description provided for @featuresIdealWeightBenefit2.
  ///
  /// In en, this message translates to:
  /// **'Set realistic goals automatically'**
  String get featuresIdealWeightBenefit2;

  /// No description provided for @featuresIdealWeightBenefit3.
  ///
  /// In en, this message translates to:
  /// **'Scientifically backed calculation'**
  String get featuresIdealWeightBenefit3;

  /// No description provided for @featuresProteinTitle.
  ///
  /// In en, this message translates to:
  /// **'Protein Intake Calculator'**
  String get featuresProteinTitle;

  /// No description provided for @featuresProteinDesc.
  ///
  /// In en, this message translates to:
  /// **'Calculate your daily protein needs based on your weight and fitness level.'**
  String get featuresProteinDesc;

  /// No description provided for @featuresProteinBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Determine daily protein requirements'**
  String get featuresProteinBenefit1;

  /// No description provided for @featuresProteinBenefit2.
  ///
  /// In en, this message translates to:
  /// **'Adjust for activity level'**
  String get featuresProteinBenefit2;

  /// No description provided for @featuresProteinBenefit3.
  ///
  /// In en, this message translates to:
  /// **'Build and maintain muscle effectively'**
  String get featuresProteinBenefit3;

  /// No description provided for @featuresProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress Tracking'**
  String get featuresProgressTitle;

  /// No description provided for @featuresProgressDesc.
  ///
  /// In en, this message translates to:
  /// **'Record and monitor your body measurements over time with an interactive chart.'**
  String get featuresProgressDesc;

  /// No description provided for @featuresProgressBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Track weight changes over time'**
  String get featuresProgressBenefit1;

  /// No description provided for @featuresProgressBenefit2.
  ///
  /// In en, this message translates to:
  /// **'Interactive progress chart'**
  String get featuresProgressBenefit2;

  /// No description provided for @featuresProgressBenefit3.
  ///
  /// In en, this message translates to:
  /// **'Stay motivated with visible data'**
  String get featuresProgressBenefit3;

  /// No description provided for @featuresGoalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart Goal Management'**
  String get featuresGoalsTitle;

  /// No description provided for @featuresGoalsDesc.
  ///
  /// In en, this message translates to:
  /// **'Set, edit, and track fitness goals with smart auto-detection of goal types.'**
  String get featuresGoalsDesc;

  /// No description provided for @featuresGoalsBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Real-time progress tracking'**
  String get featuresGoalsBenefit1;

  /// No description provided for @featuresGoalsBenefit2.
  ///
  /// In en, this message translates to:
  /// **'Edit or delete goals anytime'**
  String get featuresGoalsBenefit2;

  /// No description provided for @featuresGoalsBenefit3.
  ///
  /// In en, this message translates to:
  /// **'Visual progress indicators'**
  String get featuresGoalsBenefit3;

  /// No description provided for @featuresProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Profile'**
  String get featuresProfileTitle;

  /// No description provided for @featuresProfileDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage your profile including name, age, height, weight, and gender for personalized calculations.'**
  String get featuresProfileDesc;

  /// No description provided for @featuresProfileBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Keep your profile up to date'**
  String get featuresProfileBenefit1;

  /// No description provided for @featuresProfileBenefit2.
  ///
  /// In en, this message translates to:
  /// **'Personalized calculator results'**
  String get featuresProfileBenefit2;

  /// No description provided for @featuresProfileBenefit3.
  ///
  /// In en, this message translates to:
  /// **'Guest mode available'**
  String get featuresProfileBenefit3;

  /// No description provided for @featuresDarkModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get featuresDarkModeTitle;

  /// No description provided for @featuresDarkModeDesc.
  ///
  /// In en, this message translates to:
  /// **'Switch between light and dark themes to suit your preference and reduce eye strain.'**
  String get featuresDarkModeDesc;

  /// No description provided for @featuresDarkModeBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Easy on the eyes at night'**
  String get featuresDarkModeBenefit1;

  /// No description provided for @featuresDarkModeBenefit2.
  ///
  /// In en, this message translates to:
  /// **'Instant theme switching'**
  String get featuresDarkModeBenefit2;

  /// No description provided for @featuresDarkModeBenefit3.
  ///
  /// In en, this message translates to:
  /// **'Save battery on OLED devices'**
  String get featuresDarkModeBenefit3;

  /// No description provided for @featuresGuestTitle.
  ///
  /// In en, this message translates to:
  /// **'Guest Mode'**
  String get featuresGuestTitle;

  /// No description provided for @featuresGuestDesc.
  ///
  /// In en, this message translates to:
  /// **'Explore the app without creating an account. All data is stored locally on your device.'**
  String get featuresGuestDesc;

  /// No description provided for @featuresGuestBenefit1.
  ///
  /// In en, this message translates to:
  /// **'No account required'**
  String get featuresGuestBenefit1;

  /// No description provided for @featuresGuestBenefit2.
  ///
  /// In en, this message translates to:
  /// **'Full features available'**
  String get featuresGuestBenefit2;

  /// No description provided for @featuresGuestBenefit3.
  ///
  /// In en, this message translates to:
  /// **'Privacy-focused experience'**
  String get featuresGuestBenefit3;

  /// No description provided for @featuresCalorieBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Know your maintenance calories'**
  String get featuresCalorieBenefit1;

  /// No description provided for @featuresCalorieBenefit2.
  ///
  /// In en, this message translates to:
  /// **'Get targets for weight loss or gain'**
  String get featuresCalorieBenefit2;

  /// No description provided for @featuresCalorieBenefit3.
  ///
  /// In en, this message translates to:
  /// **'Plan your diet with precision'**
  String get featuresCalorieBenefit3;

  /// No description provided for @featuresNotificationsBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Goal progress reminders'**
  String get featuresNotificationsBenefit1;

  /// No description provided for @featuresNotificationsBenefit2.
  ///
  /// In en, this message translates to:
  /// **'Measurement update prompts'**
  String get featuresNotificationsBenefit2;

  /// No description provided for @featuresNotificationsBenefit3.
  ///
  /// In en, this message translates to:
  /// **'Keep your fitness journey consistent'**
  String get featuresNotificationsBenefit3;

  /// No description provided for @settingsLanguageNativeEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageNativeEn;

  /// No description provided for @settingsLanguageNativeCkb.
  ///
  /// In en, this message translates to:
  /// **'کوردی (سۆرانی)'**
  String get settingsLanguageNativeCkb;

  /// No description provided for @settingsLanguageNativeAr.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get settingsLanguageNativeAr;

  /// No description provided for @settingsLanguageNativeEs.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get settingsLanguageNativeEs;

  /// No description provided for @settingsNotificationsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications enabled.'**
  String get settingsNotificationsEnabled;

  /// No description provided for @settingsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Settings updated.'**
  String get settingsUpdated;

  /// No description provided for @settingsPleaseFillFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get settingsPleaseFillFields;

  /// No description provided for @settingsUpdateButton.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get settingsUpdateButton;

  /// No description provided for @settingsAccountDeleted.
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully'**
  String get settingsAccountDeleted;

  /// No description provided for @settingsFailedDelete.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete account: {error}'**
  String settingsFailedDelete(String error);

  /// No description provided for @profileSectionAccount.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get profileSectionAccount;

  /// No description provided for @profileSectionApp.
  ///
  /// In en, this message translates to:
  /// **'APP'**
  String get profileSectionApp;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profileLogout;

  /// No description provided for @profileLogoutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out of your profile'**
  String get profileLogoutSubtitle;

  /// No description provided for @profilePersonalJourney.
  ///
  /// In en, this message translates to:
  /// **'Your personal fitness journey'**
  String get profilePersonalJourney;

  /// No description provided for @profileAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profileAccount;

  /// No description provided for @loginOr.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get loginOr;

  /// No description provided for @loginViewOnboarding.
  ///
  /// In en, this message translates to:
  /// **'View Onboarding'**
  String get loginViewOnboarding;

  /// No description provided for @logoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutTitle;

  /// No description provided for @logoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutMessage;

  /// No description provided for @homeTip1.
  ///
  /// In en, this message translates to:
  /// **'Consistency beats intensity — small daily habits build lasting results.'**
  String get homeTip1;

  /// No description provided for @homeTip2.
  ///
  /// In en, this message translates to:
  /// **'Stay hydrated! Drink water before, during, and after your workout.'**
  String get homeTip2;

  /// No description provided for @homeTip3.
  ///
  /// In en, this message translates to:
  /// **'Aim for 7-9 hours of sleep to support muscle recovery and growth.'**
  String get homeTip3;

  /// No description provided for @homeTip4.
  ///
  /// In en, this message translates to:
  /// **'Track your meals — what gets measured gets managed.'**
  String get homeTip4;

  /// No description provided for @homeTip5.
  ///
  /// In en, this message translates to:
  /// **'Rest days are just as important as training days.'**
  String get homeTip5;

  /// No description provided for @homeCalculatorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Science-backed tools to guide your fitness journey'**
  String get homeCalculatorSubtitle;

  /// No description provided for @homeIdealBodyWeight.
  ///
  /// In en, this message translates to:
  /// **'Ideal Body Weight'**
  String get homeIdealBodyWeight;

  /// No description provided for @homeLogWeight.
  ///
  /// In en, this message translates to:
  /// **'Log Weight'**
  String get homeLogWeight;

  /// No description provided for @homeAthleteFallback.
  ///
  /// In en, this message translates to:
  /// **'Athlete'**
  String get homeAthleteFallback;

  /// No description provided for @homeFitnessJourney.
  ///
  /// In en, this message translates to:
  /// **'Your fitness journey at a glance'**
  String get homeFitnessJourney;

  /// No description provided for @homeNoGoalsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set fitness goals to track your progress'**
  String get homeNoGoalsSubtitle;

  /// No description provided for @homeSetGoal.
  ///
  /// In en, this message translates to:
  /// **'Set Goal'**
  String get homeSetGoal;

  /// No description provided for @homeViewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get homeViewAll;

  /// No description provided for @guestBrowsingAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Browsing as Guest'**
  String get guestBrowsingAsGuest;

  /// No description provided for @guestDataNotSaved.
  ///
  /// In en, this message translates to:
  /// **'Your data is not being saved'**
  String get guestDataNotSaved;

  /// No description provided for @guestBannerMessage.
  ///
  /// In en, this message translates to:
  /// **'Guest mode — your data won\'t be saved.'**
  String get guestBannerMessage;

  /// No description provided for @guestCreateProfile.
  ///
  /// In en, this message translates to:
  /// **'Create Profile'**
  String get guestCreateProfile;

  /// No description provided for @guestCreateFreeProfile.
  ///
  /// In en, this message translates to:
  /// **'Create Free Profile'**
  String get guestCreateFreeProfile;

  /// No description provided for @guestAlreadyHaveProfile.
  ///
  /// In en, this message translates to:
  /// **'Already have a profile? Login'**
  String get guestAlreadyHaveProfile;

  /// No description provided for @guestExitGuestMode.
  ///
  /// In en, this message translates to:
  /// **'Exit Guest Mode'**
  String get guestExitGuestMode;

  /// No description provided for @guestModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Guest Mode'**
  String get guestModeTitle;

  /// No description provided for @guestModeMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'re currently in guest mode.\n\nCreate a free profile to save your fitness data, track progress, and set goals.'**
  String get guestModeMessage;

  /// No description provided for @guestStayAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Stay as Guest'**
  String get guestStayAsGuest;

  /// No description provided for @guestBenefitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Create a profile to unlock:'**
  String get guestBenefitsTitle;

  /// No description provided for @guestBenefitSaveData.
  ///
  /// In en, this message translates to:
  /// **'Save your data'**
  String get guestBenefitSaveData;

  /// No description provided for @guestBenefitSaveDataSub.
  ///
  /// In en, this message translates to:
  /// **'Measurements & progress persist across sessions'**
  String get guestBenefitSaveDataSub;

  /// No description provided for @guestBenefitSetGoals.
  ///
  /// In en, this message translates to:
  /// **'Set goals'**
  String get guestBenefitSetGoals;

  /// No description provided for @guestBenefitSetGoalsSub.
  ///
  /// In en, this message translates to:
  /// **'Weight, protein & calorie targets'**
  String get guestBenefitSetGoalsSub;

  /// No description provided for @guestBenefitTrackProgress.
  ///
  /// In en, this message translates to:
  /// **'Track progress'**
  String get guestBenefitTrackProgress;

  /// No description provided for @guestBenefitTrackProgressSub.
  ///
  /// In en, this message translates to:
  /// **'Visualize your fitness journey over time'**
  String get guestBenefitTrackProgressSub;

  /// No description provided for @guestBenefitReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get guestBenefitReminders;

  /// No description provided for @guestBenefitRemindersSub.
  ///
  /// In en, this message translates to:
  /// **'Weight check-in notifications'**
  String get guestBenefitRemindersSub;

  /// No description provided for @guestAppFeatures.
  ///
  /// In en, this message translates to:
  /// **'App Features'**
  String get guestAppFeatures;

  /// No description provided for @guestAppFeaturesSub.
  ///
  /// In en, this message translates to:
  /// **'Explore all features'**
  String get guestAppFeaturesSub;

  /// No description provided for @guestAppInfoSub.
  ///
  /// In en, this message translates to:
  /// **'App information'**
  String get guestAppInfoSub;

  /// No description provided for @guestGetAssistance.
  ///
  /// In en, this message translates to:
  /// **'Get assistance'**
  String get guestGetAssistance;

  /// No description provided for @goalEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit {goalName} Goal'**
  String goalEditTitle(String goalName);

  /// No description provided for @goalEditCurrentWeight.
  ///
  /// In en, this message translates to:
  /// **'Current Weight ({unit})'**
  String goalEditCurrentWeight(String unit);

  /// No description provided for @goalEditTargetWeight.
  ///
  /// In en, this message translates to:
  /// **'Target Weight ({unit})'**
  String goalEditTargetWeight(String unit);

  /// No description provided for @goalEditGoalType.
  ///
  /// In en, this message translates to:
  /// **'Goal Type'**
  String get goalEditGoalType;

  /// No description provided for @goalEditLoseWeight.
  ///
  /// In en, this message translates to:
  /// **'Lose Weight'**
  String get goalEditLoseWeight;

  /// No description provided for @goalEditGainWeight.
  ///
  /// In en, this message translates to:
  /// **'Gain Weight'**
  String get goalEditGainWeight;

  /// No description provided for @goalEditMaintainWeight.
  ///
  /// In en, this message translates to:
  /// **'Maintain Weight'**
  String get goalEditMaintainWeight;

  /// No description provided for @goalEditActiveGoal.
  ///
  /// In en, this message translates to:
  /// **'Active Goal'**
  String get goalEditActiveGoal;

  /// No description provided for @goalEditSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get goalEditSave;

  /// No description provided for @goalEditCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get goalEditCancel;

  /// No description provided for @goalsInfoText.
  ///
  /// In en, this message translates to:
  /// **'Tap any goal to edit its target or toggle it on/off. Calorie and protein goals can also be set from the calculators on the Home page.'**
  String get goalsInfoText;

  /// No description provided for @goalsCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get goalsCalories;

  /// No description provided for @goalsProtein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get goalsProtein;

  /// No description provided for @goalsWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get goalsWeight;

  /// No description provided for @goalsDailyGoal.
  ///
  /// In en, this message translates to:
  /// **'Daily Goal'**
  String get goalsDailyGoal;

  /// No description provided for @goalsGoalSet.
  ///
  /// In en, this message translates to:
  /// **'Goal Set'**
  String get goalsGoalSet;

  /// No description provided for @goalsTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get goalsTotal;

  /// No description provided for @goalsActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get goalsActive;

  /// No description provided for @goalsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get goalsCompleted;

  /// No description provided for @goalsPromptBothMissing.
  ///
  /// In en, this message translates to:
  /// **'Use the calculators to set calorie and protein goals.'**
  String get goalsPromptBothMissing;

  /// No description provided for @goalsPromptCaloriesMissing.
  ///
  /// In en, this message translates to:
  /// **'Set a daily calorie goal from the calculator.'**
  String get goalsPromptCaloriesMissing;

  /// No description provided for @goalsPromptProteinMissing.
  ///
  /// In en, this message translates to:
  /// **'Set a protein intake goal from the calculator.'**
  String get goalsPromptProteinMissing;

  /// No description provided for @aboutOurMission.
  ///
  /// In en, this message translates to:
  /// **'Our Mission'**
  String get aboutOurMission;

  /// No description provided for @aboutMissionText.
  ///
  /// In en, this message translates to:
  /// **'We believe fitness is a journey, not a destination. Our mission is to make fitness tracking simple, accessible, and enjoyable for everyone. With Fitness Tracker, you\'re never alone in your fitness journey.'**
  String get aboutMissionText;

  /// No description provided for @aboutAppInformation.
  ///
  /// In en, this message translates to:
  /// **'App Information'**
  String get aboutAppInformation;

  /// No description provided for @aboutAppName.
  ///
  /// In en, this message translates to:
  /// **'App Name'**
  String get aboutAppName;

  /// No description provided for @aboutEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get aboutEmail;

  /// No description provided for @aboutDeveloperName.
  ///
  /// In en, this message translates to:
  /// **'Mohammed jameel - Apollo'**
  String get aboutDeveloperName;

  /// No description provided for @aboutBuiltWithValue.
  ///
  /// In en, this message translates to:
  /// **'Flutter & Dart'**
  String get aboutBuiltWithValue;

  /// No description provided for @notificationChannelNameFull.
  ///
  /// In en, this message translates to:
  /// **'Weight tracking reminders'**
  String get notificationChannelNameFull;

  /// No description provided for @notificationChannelDescFull.
  ///
  /// In en, this message translates to:
  /// **'Reminders to log your body weight every three days.'**
  String get notificationChannelDescFull;

  /// No description provided for @notificationTitleText.
  ///
  /// In en, this message translates to:
  /// **'Track your weight'**
  String get notificationTitleText;

  /// No description provided for @notificationBodyText.
  ///
  /// In en, this message translates to:
  /// **'Take a moment to log your latest weight measurement.'**
  String get notificationBodyText;

  /// No description provided for @calorieGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get calorieGender;

  /// No description provided for @calorieAge.
  ///
  /// In en, this message translates to:
  /// **'Age (years)'**
  String get calorieAge;

  /// No description provided for @calorieWeightKg.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get calorieWeightKg;

  /// No description provided for @calorieHeightCm.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get calorieHeightCm;

  /// No description provided for @calorieRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get calorieRequired;

  /// No description provided for @calorieInvalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get calorieInvalidNumber;

  /// No description provided for @calorieActivitySedentaryFull.
  ///
  /// In en, this message translates to:
  /// **'Sedentary (little or no exercise)'**
  String get calorieActivitySedentaryFull;

  /// No description provided for @calorieActivityLightFull.
  ///
  /// In en, this message translates to:
  /// **'Lightly Active (1-3 days/week)'**
  String get calorieActivityLightFull;

  /// No description provided for @calorieActivityModerateFull.
  ///
  /// In en, this message translates to:
  /// **'Moderately Active (3-5 days/week)'**
  String get calorieActivityModerateFull;

  /// No description provided for @calorieActivityActiveFull.
  ///
  /// In en, this message translates to:
  /// **'Very Active (6-7 days/week)'**
  String get calorieActivityActiveFull;

  /// No description provided for @calorieActivityExtraFull.
  ///
  /// In en, this message translates to:
  /// **'Extra Active (athlete/physical job)'**
  String get calorieActivityExtraFull;

  /// No description provided for @calorieGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Goal: {goal} kg/week'**
  String calorieGoalLabel(String goal);

  /// No description provided for @calorieSliderLabel.
  ///
  /// In en, this message translates to:
  /// **'{goal} kg/week'**
  String calorieSliderLabel(String goal);

  /// No description provided for @calorieCalculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calorieCalculate;

  /// No description provided for @calorieResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Calorie Results'**
  String get calorieResultsTitle;

  /// No description provided for @calorieBmrFull.
  ///
  /// In en, this message translates to:
  /// **'Basal Metabolic Rate (BMR)'**
  String get calorieBmrFull;

  /// No description provided for @calorieMaintenanceFull.
  ///
  /// In en, this message translates to:
  /// **'Maintenance Calories'**
  String get calorieMaintenanceFull;

  /// No description provided for @calorieToLoseInfo.
  ///
  /// In en, this message translates to:
  /// **'To lose {weekly}kg per week, consume {daily} calories daily'**
  String calorieToLoseInfo(String weekly, String daily);

  /// No description provided for @calorieToGainInfo.
  ///
  /// In en, this message translates to:
  /// **'To gain {weekly}kg per week, consume {daily} calories daily'**
  String calorieToGainInfo(String weekly, String daily);

  /// No description provided for @calorieGoalDescLose.
  ///
  /// In en, this message translates to:
  /// **'Lose ({weekly} kg/week)'**
  String calorieGoalDescLose(String weekly);

  /// No description provided for @calorieGoalDescGain.
  ///
  /// In en, this message translates to:
  /// **'Gain ({weekly} kg/week)'**
  String calorieGoalDescGain(String weekly);

  /// No description provided for @calorieClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get calorieClose;

  /// No description provided for @dailyCaloriesGoalDescription.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get dailyCaloriesGoalDescription;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @bodybuilderNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get bodybuilderNo;

  /// No description provided for @bodybuilderYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get bodybuilderYes;

  /// No description provided for @idealWeightSelectGender.
  ///
  /// In en, this message translates to:
  /// **'Select Your Gender'**
  String get idealWeightSelectGender;

  /// No description provided for @idealWeightHeightCm.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get idealWeightHeightCm;

  /// No description provided for @idealWeightCurrentWeightKg.
  ///
  /// In en, this message translates to:
  /// **'Current Weight (kg)'**
  String get idealWeightCurrentWeightKg;

  /// No description provided for @idealWeightTargetOptional.
  ///
  /// In en, this message translates to:
  /// **'Target Weight (kg) — Optional'**
  String get idealWeightTargetOptional;

  /// No description provided for @idealWeightValidatorEmpty.
  ///
  /// In en, this message translates to:
  /// **'Enter your {field}'**
  String idealWeightValidatorEmpty(String field);

  /// No description provided for @idealWeightValidatorInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get idealWeightValidatorInvalid;

  /// No description provided for @idealWeightYourIdeal.
  ///
  /// In en, this message translates to:
  /// **'Your Ideal Body Weight'**
  String get idealWeightYourIdeal;

  /// No description provided for @idealWeightResult.
  ///
  /// In en, this message translates to:
  /// **'Ideal Weight'**
  String get idealWeightResult;

  /// No description provided for @idealWeightCurrentWeight.
  ///
  /// In en, this message translates to:
  /// **'Current Weight'**
  String get idealWeightCurrentWeight;

  /// No description provided for @idealWeightToLose.
  ///
  /// In en, this message translates to:
  /// **'To Lose'**
  String get idealWeightToLose;

  /// No description provided for @idealWeightToGain.
  ///
  /// In en, this message translates to:
  /// **'To Gain'**
  String get idealWeightToGain;

  /// No description provided for @idealWeightNeedToLose.
  ///
  /// In en, this message translates to:
  /// **'You need to lose {diff} kg to reach your ideal weight'**
  String idealWeightNeedToLose(String diff);

  /// No description provided for @idealWeightNeedToGain.
  ///
  /// In en, this message translates to:
  /// **'You need to gain {diff} kg to reach your ideal weight'**
  String idealWeightNeedToGain(String diff);

  /// No description provided for @idealWeightGotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it!'**
  String get idealWeightGotIt;

  /// No description provided for @proteinYourIntake.
  ///
  /// In en, this message translates to:
  /// **'Your Protein Intake'**
  String get proteinYourIntake;

  /// No description provided for @proteinBodybuilderPlan.
  ///
  /// In en, this message translates to:
  /// **'Bodybuilder Plan'**
  String get proteinBodybuilderPlan;

  /// No description provided for @proteinRegularPlan.
  ///
  /// In en, this message translates to:
  /// **'Regular Plan'**
  String get proteinRegularPlan;

  /// No description provided for @proteinDailyRange.
  ///
  /// In en, this message translates to:
  /// **'Daily Protein Range'**
  String get proteinDailyRange;

  /// No description provided for @proteinMinimum.
  ///
  /// In en, this message translates to:
  /// **'Minimum'**
  String get proteinMinimum;

  /// No description provided for @proteinTo.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get proteinTo;

  /// No description provided for @proteinMaximum.
  ///
  /// In en, this message translates to:
  /// **'Maximum'**
  String get proteinMaximum;

  /// No description provided for @proteinBodybuilderHint.
  ///
  /// In en, this message translates to:
  /// **'As a bodybuilder, consume protein throughout the day for optimal muscle growth.'**
  String get proteinBodybuilderHint;

  /// No description provided for @proteinDailyIntake.
  ///
  /// In en, this message translates to:
  /// **'Daily Protein Intake'**
  String get proteinDailyIntake;

  /// No description provided for @proteinRegularHint.
  ///
  /// In en, this message translates to:
  /// **'This is the recommended daily protein intake for a healthy lifestyle.'**
  String get proteinRegularHint;

  /// No description provided for @proteinGotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it!'**
  String get proteinGotIt;

  /// No description provided for @proteinEnterWeight.
  ///
  /// In en, this message translates to:
  /// **'Enter your weight'**
  String get proteinEnterWeight;

  /// No description provided for @measurementUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Your Weight'**
  String get measurementUpdateTitle;

  /// No description provided for @measurementUpdateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Updates your weight goal progress automatically'**
  String get measurementUpdateSubtitle;

  /// No description provided for @measurementWeightGoalAuto.
  ///
  /// In en, this message translates to:
  /// **'Your weight goal will be automatically updated with this measurement.'**
  String get measurementWeightGoalAuto;

  /// No description provided for @measurementError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String measurementError(String error);

  /// No description provided for @privacyContactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get privacyContactInfo;

  /// No description provided for @privacyContactMessage.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions about this Privacy Policy, please contact us at:'**
  String get privacyContactMessage;

  /// No description provided for @privacyContactEmail.
  ///
  /// In en, this message translates to:
  /// **'mahamadbarznji712@gmail.com'**
  String get privacyContactEmail;

  /// No description provided for @termsContactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get termsContactInfo;

  /// No description provided for @termsContactMessage.
  ///
  /// In en, this message translates to:
  /// **'For questions about these Terms & Conditions:'**
  String get termsContactMessage;

  /// No description provided for @termsContactEmail.
  ///
  /// In en, this message translates to:
  /// **'mahamadbarznji712@gmail.com'**
  String get termsContactEmail;

  /// No description provided for @supportNeedHelp.
  ///
  /// In en, this message translates to:
  /// **'Need Help?'**
  String get supportNeedHelp;

  /// No description provided for @supportContactTeam.
  ///
  /// In en, this message translates to:
  /// **'Contact our support team:'**
  String get supportContactTeam;

  /// No description provided for @supportSupportEmail.
  ///
  /// In en, this message translates to:
  /// **'Support Email'**
  String get supportSupportEmail;

  /// No description provided for @onboardingTagWelcome.
  ///
  /// In en, this message translates to:
  /// **'WELCOME'**
  String get onboardingTagWelcome;

  /// No description provided for @onboardingTagProgress.
  ///
  /// In en, this message translates to:
  /// **'PROGRESS'**
  String get onboardingTagProgress;

  /// No description provided for @onboardingTagGoals.
  ///
  /// In en, this message translates to:
  /// **'GOALS'**
  String get onboardingTagGoals;

  /// No description provided for @onboardingTagCalculators.
  ///
  /// In en, this message translates to:
  /// **'CALCULATORS'**
  String get onboardingTagCalculators;

  /// No description provided for @onboardingTagPersonalized.
  ///
  /// In en, this message translates to:
  /// **'PERSONALIZED'**
  String get onboardingTagPersonalized;

  /// Short unit for grams
  ///
  /// In en, this message translates to:
  /// **'g'**
  String get proteinGramsShort;

  /// Grams per day unit
  ///
  /// In en, this message translates to:
  /// **'g/day'**
  String get proteinGramsPerDay;

  /// No description provided for @homeAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Fitness Tracker'**
  String get homeAppTitle;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'ckb', 'en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'ckb': return AppLocalizationsCkb();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
