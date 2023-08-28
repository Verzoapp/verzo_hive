import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/authentication_service.dart';
import 'package:verzo_one/ui/base/authentication_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'create_account_view.form.dart';

class CreateAccountViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  bool isPasswordVisible = false;

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
  // CreateAccountViewModel() : super(successRoute: Routes.verificationRoute);

  // // Password validation method
  // bool isPasswordValid(String password) {
  //   // Password must be at least 8 characters long
  //   if (password.length < 8) return false;

  //   // Regex patterns to check for uppercase, lowercase, special character, and number
  //   final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
  //   final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
  //   final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  //   final hasNumber = RegExp(r'[0-9]').hasMatch(password);

  //   // Check if all conditions are met
  //   return hasUppercase && hasLowercase && hasSpecialChar && hasNumber;
  // }

//   bool isPasswordValid(String password) {
//   // Use a single regular expression to check all conditions
//   final passwordRegex = RegExp(
//     r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
//   );

//   // Check if the password matches the regular expression
//   return passwordRegex.hasMatch(password);
// }

  Future<CreateAccountWithEmailResult> runAuthentication() =>
      _authenticationService.createAccountWithEmail(
          email: emailValue ?? '',
          password: passwordValue ?? '',
          fullName: fullNameValue ?? '');

  Future saveData() async {
    final result = await runBusyFuture(runAuthentication());

    // if (!isPasswordValid(passwordValue ?? '')) {
    //   setValidationMessage(
    //       'Password must be at least 8 characters, contain at least one uppercase letter, one special character, one lowercase letter, and one number.');
    //   return;
    // // }

    // setValidationMessage(null); // Clear previous validation message

    if (result.tokens != null) {
      // navigate to success route
      navigationService.replaceWith(Routes.verificationRoute);
    } else if (result.error != null) {
      setValidationMessage(result.error?.message);
    } else {
      // handle other errors
    }
  }

  void navigateToLogin() => navigationService.navigateTo(Routes.loginRoute);

  void navigateBack() => navigationService.back();

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }
}
