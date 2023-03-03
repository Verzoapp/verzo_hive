import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_view.form.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_view_model.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

@FormView(fields: [
  FormTextField(name: 'name'),
  FormTextField(name: 'businessId'),
])
class CreateMerchantView extends StatelessWidget with $CreateMerchantView {
  final bool busy;

  CreateMerchantView({Key? key, this.busy = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateMerchantViewModel>.reactive(
      viewModelBuilder: () => CreateMerchantViewModel(),
      onModelReady: (model) => () {},
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: ListView(
            children: [
              verticalSpaceRegular,
              Text('Create Merchant', //title
                  style: ktsHeaderText),
              verticalSpaceSmall,
              Text('Please fill the form below to create a Merchant', //subtitle
                  style: ktsParagraphText),
              verticalSpaceRegular,
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Merchant name',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                controller: nameController,
              ),
              verticalSpaceSmall,
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Business Id',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                controller: businessIdController,
              ),
              verticalSpaceRegular,
              GestureDetector(
                onTap: model.saveData,
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
                          'Create',
                          style: ktsButtonText,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
