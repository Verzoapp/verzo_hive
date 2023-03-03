import 'package:verzo_one/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/ui/create_account/create_account_view.form.dart';
import 'package:verzo_one/ui/verification/verification_view.form.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';

class ForgotPasswordViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  @override
  void setFormStatus() {}

  Future<AuthenticationResult> runAuthentication() => _authenticationService
      .loginWithEmail(email: emailValue ?? '', password: passwordValue ?? '');

  Future saveData() async {
    final result = await runBusyFuture(runAuthentication());

    if (result != null) {
      // navigate to success route
      navigationService.replaceWith(Routes.loginRoute);
    } else if (result.error != null) {
      setValidationMessage(result.error?.message);
    } else {
      // handle other errors
    }
  }
}
