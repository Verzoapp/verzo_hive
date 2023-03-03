import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/services/otp_verification_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';

import 'package:verzo_one/ui/verification/verification_view.form.dart';

class VerificationViewModel extends FormViewModel {
  final OTPVerificationService _otpVerificationService =
      locator<OTPVerificationService>();
  final FocusNode digit2FocusNode = FocusNode();
  final FocusNode digit3FocusNode = FocusNode();
  final FocusNode digit4FocusNode = FocusNode();
  final NavigationService navigationService = locator<NavigationService>();

  String otpDigit1 = '';
  String otpDigit2 = '';
  String otpDigit3 = '';
  String otpDigit4 = '';

  void setOTPDigit1(String value) {
    otpDigit1 = value;
    if (value.length == 1) {
      digit2FocusNode.requestFocus();
    }
  }

  void setOTPDigit2(String value) {
    otpDigit2 = value;
    if (value.length == 1) {
      digit3FocusNode.requestFocus();
    }
  }

  void setOTPDigit3(String value) {
    otpDigit3 = value;
    if (value.length == 1) {
      digit4FocusNode.requestFocus();
    }
  }

  void setOTPDigit4(String value) {
    otpDigit4 = value;
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }

  Future<VerificationResult> runVerification() =>
      _otpVerificationService.verifyOTP(
          code: double.parse('$otp1Value$otp2Value$otp3Value$otp4Value'));

  Future getVerificationResponse() async {
    final result = await runBusyFuture(runVerification());

    if (result.verificationResponse?.isSuccessful != null) {
      navigationService.replaceWith(Routes.businessProfileCreationRoute);
    } else if (result.error != null) {
      setValidationMessage(result.error?.message);
    } else {
      // handle other errors
    }
  }

  void navigateToCreateAccount() =>
      navigationService.navigateTo(Routes.createAccountRoute);
}
