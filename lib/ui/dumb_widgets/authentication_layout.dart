import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class AuthenticationLayout extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? mainButtonTitle;
  final String? secondaryButtonTitle;
  final Widget? form;
  final bool showTermsText;
  final Function()? onMainButtonTapped;
  final Function()? onSecondaryButtonTapped;
  final Function()? onCreateAccountTapped;
  final Function()? onLoginTapped;
  final Function()? onResendVerificationCodeTapped;
  final Function()? onForgotPassword;
  // final Function()? onForgotPasswordResend;
  final Function()? onBackPressed;
  final String? validationMessage;
  final bool busy;

  const AuthenticationLayout(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.mainButtonTitle,
      this.secondaryButtonTitle,
      required this.form,
      this.showTermsText = false,
      this.onMainButtonTapped,
      this.onSecondaryButtonTapped,
      this.onCreateAccountTapped,
      this.onLoginTapped,
      this.onResendVerificationCodeTapped,
      this.onForgotPassword,
      // this.onForgotPasswordResend,
      this.onBackPressed,
      this.validationMessage,
      this.busy = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(children: [
        if (onBackPressed == null) verticalSpaceTiny,
        if (onBackPressed != null)
          IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kcTextColor,
            ),
            onPressed: onBackPressed,
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/verzo_logo.svg',
              width: 110,
              height: 30,
            )
          ],
        ),
        verticalSpaceRegular,
        Text(
          title!,
          style: ktsHeaderText,
        ),
        verticalSpaceTiny,
        Text(
          subtitle!,
          style: ktsParagraphText,
        ),
        verticalSpaceRegular,
        form!,
        verticalSpaceTiny,
        if (onForgotPassword == null) verticalSpaceIntermitent,
        if (onForgotPassword != null)
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () async {
                String url = "https://alpha.verzo.app/forgotPassword";
                var urllaunchable = await canLaunchUrlString(
                    url); //canLaunch is from url_launcher package
                if (urllaunchable) {
                  await launchUrlString(
                      url); //launch is from url_launcher package to launch URL
                } else {}
              },
              child: Text(
                'Forgot Password?',
                style: ktsforgotpasswordText,
              ),
            ),
          ),
        if (onForgotPassword != null) verticalSpaceRegular,
        if (validationMessage != null)
          Text(
            validationMessage!,
            style: const TextStyle(
              color: Colors.red,
              fontSize: kBodyTextSize,
            ),
          ),
        if (validationMessage != null) verticalSpaceRegular,
        GestureDetector(
          onTap: onMainButtonTapped,
          child: Container(
            width: double.infinity,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: defaultBorderRadius,
              color: kcPrimaryColor,
            ),
            child: busy
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )
                : Text(
                    mainButtonTitle!,
                    style: ktsButtonText,
                  ),
          ),
        ),
        verticalSpaceSmall,
        if (secondaryButtonTitle != null)
          GestureDetector(
            onTap: onSecondaryButtonTapped,
            child: Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: defaultBorderRadius,
                  color: kcButtonTextColor,
                  border: Border.all(
                      color: kcPrimaryColor.withOpacity(0.6), width: 1)),
              child: busy
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(kcPrimaryColor),
                    )
                  : Text(
                      secondaryButtonTitle!,
                      style: ktsButtonTextBlue,
                    ),
            ),
          ),
        verticalSpaceSmall,
        if (showTermsText == true)
          Text(
            'By proceeding you agree to our Terms & Condition and Privacy Policy',
            style: ktsSmallBodyText,
            textAlign: TextAlign.center,
          ),
        if (onCreateAccountTapped != null) verticalSpaceLarge,
        if (onCreateAccountTapped != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account? ',
                style: ktsBodyTextLight,
              ),
              GestureDetector(
                onTap: onCreateAccountTapped,
                child: const Text('Sign Up',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: kcPrimaryColor,
                    )),
              )
            ],
          ),
        if (onLoginTapped != null) verticalSpaceMedium,
        if (onLoginTapped != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: ktsBodyTextLight,
              ),
              GestureDetector(
                onTap: onLoginTapped,
                child: const Text(
                  'Login',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: kcPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        if (onResendVerificationCodeTapped != null) verticalSpaceSmall,
        if (onResendVerificationCodeTapped != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Didn\'t recieve the code? ',
                style: ktsBodyTextLight,
              ),
              GestureDetector(
                onTap: onResendVerificationCodeTapped,
                child: const Text('Re-send',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: kcPrimaryColor,
                    )),
              )
            ],
          ),
        // if (onForgotPasswordResend != null) verticalSpaceSmall,
        // if (onForgotPasswordResend != null)
        // Align(
        //   alignment: Alignment.center,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         'Didn\'t recieve an email? Change email address or ',
        //         style: ktsBodyTextLight,
        //       ),
        //       GestureDetector(
        //         onTap: (() {}),
        //         child: const Text('Resend email',
        //             style: TextStyle(
        //               decoration: TextDecoration.underline,
        //               color: kcPrimaryColor,
        //             )),
        //       )
        //     ],
        //   ),
        // ),
      ]),
    );
  }
}
