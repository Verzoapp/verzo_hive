import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/services/verzo_auth_service.dart';

class AppAuthService with ReactiveServiceMixin {
  final verzoAuthService = VerzoAuthService();

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> login(String email, String password) async {
    // Use the `login` method from the `VerzoAuthService` to sign in the user
    final Map<String, String> result =
        await verzoAuthService.login(email, password);

    // Save the access token and refresh token in shared preferences

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', result['access_token'] ?? "");
    prefs.setString('refresh_token', result['refresh_token'] ?? "");
    prefs.setBool('isLoggedIn', true);

    if (result.isNotEmpty) {
      print('login success');
    }

    // Notify listeners that the `isLoggedIn` property has changed
    notifyListeners();
  }

  Future<void> logout(String userId) async {
    // Use the `logout` method from the `VerzoAuthService` to log out the user
    await verzoAuthService.logout(userId);

    // Notify listeners that the `isLoggedIn` property has changed
    notifyListeners();
  }

  Future<void> register(String email, String password, String fullname) async {
    // Use the `register` method from the `VerzoAuthService` to register a new user
    await verzoAuthService.register(email, password, fullname);

    // Notify listeners that the `isLoggedIn` property has changed
    notifyListeners();
  }
}
