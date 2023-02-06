import 'package:flutter/services.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';
import 'package:verzo_one/ui/verification/verification_view.form.dart';
import 'package:verzo_one/ui/verification/verification_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'OTP'),
])
class VerificationView extends StatelessWidget with $VerificationView {
  VerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerificationViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      viewModelBuilder: () => VerificationViewModel(),
      builder: (context, model, child) => Scaffold(
          body: AuthenticationLayout(
        onBackPressed: () {},
        busy: model.isBusy,
        onMainButtonTapped: model.saveData,
        onVerifyTapped: () {},
        validationMessage: model.validationMessage,
        title: 'Verification',
        subtitle: 'Enter the OTP code sent to your email',
        form: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter OTP',
                  labelStyle: ktsFormText,
                  border: defaultFormBorder),
            ),
            verticalSpaceTiny,
          ],
        ),
        mainButtonTitle: 'Verify',
        showTermsText: false,
      )),
    );
  }
}
