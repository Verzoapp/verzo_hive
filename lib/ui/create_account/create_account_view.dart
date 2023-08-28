import 'package:verzo_one/ui/create_account/create_account_view.form.dart';
import 'package:verzo_one/ui/create_account/create_account_viewmodel.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

@FormView(fields: [
  FormTextField(name: 'fullName'),
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
])
class CreateAccountView extends StatelessWidget with $CreateAccountView {
  CreateAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateAccountViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      viewModelBuilder: () => CreateAccountViewModel(),
      builder: (context, model, child) => Scaffold(
          body: AuthenticationLayout(
        busy: model.isBusy,
        onMainButtonTapped: model.saveData,
        onLoginTapped: model.navigateToLogin,
        validationMessage: model.validationMessage,
        title: 'Create Account',
        subtitle: 'Create an account to sign up',
        mainButtonTitle: 'Sign Up',
        form: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    // prefixIcon: const Icon(Icons.email),
                    labelText: 'Enter email',
                    labelStyle: ktsFormText,
                    fillColor: kcFillColor,
                    filled: true,
                    enabledBorder: defaultFormBorder,
                    focusedBorder: defaultFocusedFormBorder),
                style: ktsBodyText,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                // validator: ((value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter an email';
                //   }
                // }),
              ),
              verticalSpaceSmall,
              TextFormField(
                obscureText: !model.isPasswordVisible,
                decoration: InputDecoration(
                    labelText: 'Password',
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
              verticalSpaceSmall,
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Full name',
                  labelStyle: ktsFormText,
                  fillColor: kcFillColor,
                  filled: true,
                  enabledBorder: defaultFormBorder,
                  focusedBorder: defaultFocusedFormBorder,
                ),
                textCapitalization: TextCapitalization.words,
                style: ktsBodyText,
                controller: fullNameController,
                keyboardType: TextInputType.name,
              ),
            ],
          ),
        ),
        showTermsText: true,
      )),
    );
  }
}
