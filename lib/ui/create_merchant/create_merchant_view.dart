import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_view.form.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_viewmodel.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

@FormView(fields: [
  FormTextField(name: 'name'),
  FormTextField(name: 'email'),
])
class CreateMerchantView extends StatelessWidget with $CreateMerchantView {
  CreateMerchantView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateMerchantViewModel>.reactive(
      viewModelBuilder: () => CreateMerchantViewModel(),
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox.fromSize(
          size: Size.fromHeight(MediaQuery.of(context).size.height * 0.7),
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                children: [
                  Text(
                    "Create a Merchant",
                    style: ktsHeaderText,
                  ),
                  verticalSpaceSmall,
                  Text(
                    "Pls fill the form to create a merchant",
                    style: ktsParagraphText,
                  ),
                  verticalSpaceSmall,
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Merchant name',
                        labelStyle: ktsFormText,
                        border: defaultFormBorder),
                    keyboardType: TextInputType.name,
                    controller: nameController,
                  ),
                  verticalSpaceSmall,
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Merchant email',
                        labelStyle: ktsFormText,
                        border: defaultFormBorder),
                    keyboardType: TextInputType.name,
                    controller: emailController,
                  ),
                  verticalSpaceMedium,
                  GestureDetector(
                    onTap: model.saveMerchantData,
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: defaultBorderRadius,
                        color: kcPrimaryColor,
                      ),
                      child: model.isBusy
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : Text(
                              "Create",
                              style: ktsButtonText,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
