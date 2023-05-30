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
  FormTextField(name: 'otp1'),
  FormTextField(name: 'otp2'),
  FormTextField(name: 'otp3'),
  FormTextField(name: 'otp4'),
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
        onBackPressed: model.navigateBack,
        busy: model.isBusy,
        onMainButtonTapped: model.getVerificationResponse,
        onResendVerificationCodeTapped: () {},
        validationMessage: model.validationMessage,
        title: 'Verification',
        subtitle: 'We have sent the verification code to your email',
        form: Form(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: '0',
                        labelStyle: ktsFormText,
                        border: defaultFormBorder),
                    controller: otp1Controller,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    onSaved: (pin1) {},
                  ),
                ),
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: '0',
                        labelStyle: ktsFormText,
                        border: defaultFormBorder),
                    controller: otp2Controller,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    onSaved: (pin2) {},
                  ),
                ),
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: '0',
                        labelStyle: ktsFormText,
                        border: defaultFormBorder),
                    controller: otp3Controller,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    onSaved: (pin3) {},
                  ),
                ),
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: '0',
                        labelStyle: ktsFormText,
                        border: defaultFormBorder),
                    controller: otp4Controller,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    onSaved: (pin4) {},
                  ),
                ),
              ],
            ),
          ),
        ),
        mainButtonTitle: 'Verify',
        showTermsText: false,
      )),
    );
  }
}
