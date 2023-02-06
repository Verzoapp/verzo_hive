import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../services/authentication_service.dart';

class BusinessProfileCreationViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  String _businessName = '';
  String _businessLocation = '';
  String _email = '';
  String _contactName = '';
  String _phoneNumber = '';

  String get businessName => _businessName;
  String get businessLocation => _businessLocation;
  String get email => _email;
  String get contactName => _contactName;
  String get phoneNumber => _phoneNumber;

  void setBusinessName(String businessName) {
    _businessName = businessName;
    notifyListeners();
  }

  void setBusinessLocation(String businessLocation) {
    _businessLocation = businessLocation;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setContactName(String contactName) {
    _contactName = contactName;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void createBusinessProfile() {
    // Code to create business profile
  }
}
