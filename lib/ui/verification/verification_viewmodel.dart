import 'dart:async';

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
  final DialogService dialogService = locator<DialogService>();

  int resendCounter = 0;
  Timer? resendCooldownTimer;

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

  Future<bool> resendVerification() async {
    if (resendCounter >= 1) {
      // Check if the resend counter has reached the limit
      if (resendCooldownTimer == null || !resendCooldownTimer!.isActive) {
        // Start the cooldown timer for 3 minutes
        resendCooldownTimer = Timer(const Duration(minutes: 3), () {
          resendCooldownTimer = null;
          resendCounter = 0;
          notifyListeners(); // Update the UI after cooldown
        });

        await dialogService.showDialog(
          dialogPlatform: DialogPlatform.Cupertino,
          title: 'Resend Verification',
          description: 'We have resent a verification code to your email',
          barrierDismissible: true,
        );

        bool verificationResent =
            await _otpVerificationService.resendVerification();
        return verificationResent;
      } else {
        // Resend button is on cooldown

        await dialogService.showDialog(
          dialogPlatform: DialogPlatform.Cupertino,
          title: "Resend Verification Failed",
          description: 'Resend button disabled: try again in 3 minutes',
          barrierDismissible: true,
        );
        return false;
      }
    } else {
      // Increment the resend counter and resend the verification code
      resendCounter++;

      await dialogService.showDialog(
        dialogPlatform: DialogPlatform.Cupertino,
        title: 'Resend Verification',
        description: 'We have resent a verification code to your email',
        barrierDismissible: true,
      );

      bool verificationResent =
          await _otpVerificationService.resendVerification();
      return verificationResent;
    }
  }

  Future<VerificationResult> runVerification() {
    final otpValue =
        '${otp1Value ?? ''}${otp2Value ?? ''}${otp3Value ?? ''}${otp4Value ?? ''}';
    final otpCode = double.tryParse(otpValue) ?? 0.0;

    return _otpVerificationService.verifyOTP(code: otpCode);
  }

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

  void navigateBack() => navigationService.back();
}
