import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/authentication_service.dart';
import 'package:verzo_one/ui/base/authentication_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'create_account_view.form.dart';

class CreateAccountViewModel extends AuthenticationViewModel {
  final _authenticationService = locator<AuthenticationService>();

  CreateAccountViewModel() : super(successRoute: Routes.loginRoute);

  @override
  Future<CreateAccountWithEmailResult> runAuthentication() =>
      _authenticationService.createAccountWithEmail(
          email: emailValue ?? '',
          password: passwordValue ?? '',
          fullName: fullNameValue ?? '');

  void navigateBack() => navigationService.back();
}
