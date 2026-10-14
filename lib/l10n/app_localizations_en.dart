// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get startTitle => '  Personalize Your Experience';

  @override
  String get startDesc =>
      ' Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.';

  @override
  String get lang => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get login => 'Login';

  @override
  String get loginTitle => 'Login to your account';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get enterEmail => 'Enter Email';

  @override
  String get enterValidEmail => 'Enter valid Email';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get passwordTooShort => 'Enter More Than 6 char';

  @override
  String get forgetPassword => 'Forget Password?';

  @override
  String get dontHaveAccount => 'Don’t have an account? ';

  @override
  String get signUp => 'Signup';
}
