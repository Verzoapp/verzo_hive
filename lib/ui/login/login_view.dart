import 'package:flutter/services.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/login/login_view.form.dart';
import 'package:verzo_one/ui/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
])
class LoginView extends StatelessWidget with $LoginView {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
          body: AuthenticationLayout(
        busy: model.isBusy,
        onMainButtonTapped: model.saveData,
        // onSecondaryButtonTapped: (() {}),
        onCreateAccountTapped: model.navigateToCreateAccount,
        validationMessage: model.validationMessage,
        title: 'Welcome to Verzo',
        subtitle: 'Please kindly input your details to Login',
        form: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Enter email *',
                    labelStyle: ktsFormText,
                    fillColor: kcFillColor,
                    filled: true,
                    // border: defaultFormBorder,
                    enabledBorder: defaultFormBorder,
                    focusedBorder: defaultFocusedFormBorder),
                // textCapitalization: TextCapitalization.words,
                style: ktsBodyText,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid email';
                  }
                }),
              ),
              verticalSpaceSmall,
              TextFormField(
                obscureText: !model.isPasswordVisible,
                decoration: InputDecoration(
                    labelText: 'Password *',
                    labelStyle: ktsFormText,
                    fillColor: kcFillColor,
                    filled: true,
                    enabledBorder: defaultFormBorder,
                    focusedBorder: defaultFocusedFormBorder,
                    suffixIcon: GestureDetector(
                      onTap: model.togglePasswordVisibility,
                      child: Icon(model.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    )),
                style: ktsBodyText,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
              ),
            ],
          ),
        ),
        onForgotPassword: model.navigateToForgotPassword,
        mainButtonTitle: 'Login',
        // secondaryButtonTitle: 'Continue with Google',
        // showTermsText: true,
      )),
    );
  }
}
