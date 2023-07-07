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

  Future<CreateAccountWithEmailResult> runAuthentication() =>
      _authenticationService.createAccountWithEmail(
          email: emailValue ?? '',
          password: passwordValue ?? '',
          fullName: fullNameValue ?? '');

  Future saveData() async {
    final result = await runBusyFuture(runAuthentication());

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
