import 'package:flutter_svg/svg.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class AuthenticationLayout extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? mainButtonTitle;
  final Widget? form;
  final bool showTermsText;
  final Function()? onMainButtonTapped;
  final Function()? onCreateAccountTapped;
  final Function()? onLoginTapped;
  final Function()? onVerifyTapped;
  final Function()? onForgotPassword;
  final Function()? onForgotPasswordResend;
  final Function()? onBackPressed;
  final String? validationMessage;
  final bool busy;

  const AuthenticationLayout(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.mainButtonTitle,
      required this.form,
      this.showTermsText = false,
      this.onMainButtonTapped,
      this.onCreateAccountTapped,
      this.onLoginTapped,
      this.onVerifyTapped,
      this.onForgotPassword,
      this.onForgotPasswordResend,
      this.onBackPressed,
      this.validationMessage,
      this.busy = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: ListView(children: [
        if (onBackPressed == null) verticalSpaceTiny,
        if (onBackPressed != null) verticalSpaceTiny,
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
        if (onBackPressed == null) verticalSpaceTiny,
        if (onBackPressed != null) verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/verzo_logo.svg',
              width: 102,
              height: 21,
            )
          ],
        ),
        verticalSpaceRegular,
        Text(
          title!,
          style: ktsHeaderText,
        ),
        verticalSpaceSmall,
        Text(
          subtitle!,
          style: ktsParagraphText,
        ),
        verticalSpaceRegular,
        form!,
        verticalSpaceTiny,
        if (onForgotPassword != null)
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onForgotPassword,
              child: Text('Forgot Password?', style: ktsSmallBodyText),
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
        if (showTermsText == true)
          Text(
            'By proceeding you agree to our Terms & Condition and Privacy Policy',
            style: ktsSmallBodyText,
            textAlign: TextAlign.center,
          ),
        verticalSpaceLarge,
        if (onCreateAccountTapped != null)
          GestureDetector(
            onTap: onCreateAccountTapped,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account? ',
                  style: ktsBodyTextLight,
                ),
                const Text('Sign Up',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: kcPrimaryColor,
                    ))
              ],
            ),
          ),
        if (onLoginTapped != null)
          GestureDetector(
            onTap: onLoginTapped,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: ktsBodyTextLight,
                ),
                const Text('Login',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: kcPrimaryColor,
                    ))
              ],
            ),
          ),
        if (onVerifyTapped != null)
          GestureDetector(
            onTap: onVerifyTapped,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Didn\'t recieve a code? ',
                  style: ktsBodyTextLight,
                ),
                const Text('Re-send',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: kcPrimaryColor,
                    ))
              ],
            ),
          ),
        if (onForgotPasswordResend != null)
          GestureDetector(
              onTap: onForgotPasswordResend,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn\'t recieve an email? Change email address or ',
                      style: ktsBodyTextLight,
                    ),
                    const Text('Resend email',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: kcPrimaryColor,
                        ))
                  ],
                ),
              )),
      ]),
    );
  }
}
