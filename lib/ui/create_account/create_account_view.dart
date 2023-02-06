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
  FormTextField(name: 'phoneNumber'),
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
        onMainButtonTapped: () => model.saveData(),
        onLoginTapped: () {},
        onBackPressed: model.navigateBack,
        validationMessage: model.validationMessage,
        title: 'Create Account',
        subtitle: 'Create an account to sign up.',
        mainButtonTitle: 'Create',
        form: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter email',
                  labelStyle: ktsFormText,
                  border: defaultFormBorder),
              controller: emailController,
            ),
            verticalSpaceSmall,
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: ktsFormText,
                  border: defaultFormBorder),
              controller: passwordController,
            ),
            verticalSpaceSmall,
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter full name',
                  labelStyle: ktsFormText,
                  border: defaultFormBorder),
              controller: fullNameController,
            ),
            verticalSpaceSmall,
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Phone number',
                  labelStyle: ktsFormText,
                  border: defaultFormBorder),
              controller: fullNameController,
            ),
          ],
        ),
        showTermsText: true,
      )),
    );
  }
}