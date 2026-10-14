// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get startTitle => 'تخصص تجريبتك';

  @override
  String get startDesc =>
      'اختر المظهر واللغة المفضلة لديك للبدء بتجربة مريحة ومخصصة تناسب أسلوبك.';

  @override
  String get lang => 'اللغة';

  @override
  String get theme => 'المظهر';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get loginTitle => 'تسجيل الدخول إلى حسابك';

  @override
  String get emailHint => 'أدخل بريدك الإلكتروني';

  @override
  String get enterEmail => 'أدخل البريد الإلكتروني';

  @override
  String get enterValidEmail => 'أدخل بريد إلكتروني صالح';

  @override
  String get passwordHint => 'أدخل كلمة المرور';

  @override
  String get enterPassword => 'أدخل كلمة المرور';

  @override
  String get passwordTooShort => 'أدخل أكثر من 6 أحرف';

  @override
  String get forgetPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟ ';

  @override
  String get signUp => 'إنشاء حساب';
}
