import 'package:verzo_one/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';

import 'login_view.form.dart';

class LoginViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  @override
  void setFormStatus() {}

  Future<AuthenticationResult> runAuthentication() => _authenticationService
      .loginWithEmail(email: emailValue ?? '', password: passwordValue ?? '');

  Future saveData() async {
    final result = await runBusyFuture(runAuthentication());

    if (result.tokens != null) {
      // navigate to success route
      navigationService.replaceWith(Routes.homeScreenRoute);
    } else if (result.error != null) {
      setValidationMessage(result.error?.message);
    } else {
      // handle other errors
    }
  }

  void navigateToCreateAccount() =>
      navigationService.navigateTo(Routes.createAccountRoute);
}
