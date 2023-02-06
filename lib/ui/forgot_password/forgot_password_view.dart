import 'package:flutter/services.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:verzo_one/ui/forgot_password/forgot_password_view.form.dart';
import 'package:verzo_one/ui/forgot_password/forgot_password_viewmodel.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

@FormView(fields: [
  FormTextField(name: 'OTP'),
])
class ForgotPasswordView extends StatelessWidget with $ForgotPasswordView {
  ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      viewModelBuilder: () => ForgotPasswordViewModel(),
      builder: (context, model, child) => Scaffold(
          body: AuthenticationLayout(
        onBackPressed: () {},
        busy: model.isBusy,
        onMainButtonTapped: model.saveData,
        onForgotPasswordResend: () {},
        validationMessage: model.validationMessage,
        title: 'Forgot Password',
        subtitle: 'Please kindly input your email address',
        form: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter Email',
                  labelStyle: ktsFormText,
                  border: defaultFormBorder),
            ),
            verticalSpaceTiny,
          ],
        ),
        mainButtonTitle: 'Submit',
        showTermsText: false,
      )),
    );
  }
}
