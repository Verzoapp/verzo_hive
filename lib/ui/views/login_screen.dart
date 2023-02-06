import '../../app/app.locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.router.dart';
import '../../helpers/auth_helper.dart';
import 'first_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // IMPLEMENTATION NOTE: Services should never be used directly in a view refer to
    // https://www.filledstacks.com/post/flutter-and-provider-architecture-using-stacked/#how-does-stacked-work
    // for more details.
    NavigationService _navigationService = locator<NavigationService>();
    final authService = AppAuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Using custom transitions and passing the \npage instead of Route name",
              softWrap: true,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            OutlinedButton(
              child: Text("Clear Till First and Show"),
              onPressed: () async {
                await authService.login("segunafo@gmail.com", "password");
              },
            ),
          ],
        ),
      ),
    );
  }
}
