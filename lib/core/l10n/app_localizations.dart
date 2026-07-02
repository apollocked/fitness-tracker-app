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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
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

  /// No description provided for @featuresProteinDesc.
  ///
  /// In en, this message translates to:
  /// **'Calculate daily protein needs based on activity level.'**
  String get featuresProteinDesc;

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

  /// No description provided for @featuresProgressDesc.
  ///
  /// In en, this message translates to:
  /// **'Visualize your weight trends with charts and track goal progress.'**
  String get featuresProgressDesc;

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
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'ckb', 'en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'ckb':
      return AppLocalizationsCkb();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
