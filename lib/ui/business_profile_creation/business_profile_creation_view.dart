import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:verzo_one/services/business_profile_service.dart';
import 'package:verzo_one/ui/business_profile_creation/business_profile_creation_view.form.dart';
import 'package:verzo_one/ui/business_profile_creation/business_profile_creation_viewmodel.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

@FormView(fields: [
  FormTextField(name: 'businessName'),
  FormTextField(name: 'businessEmail'),
  FormTextField(name: 'businessMobile'),
  FormTextField(name: 'businessCategoryId'),
])
class BusinessProfileCreationView extends StatelessWidget
    with $BusinessProfileCreationView {
  BusinessProfileCreationView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusinessProfileCreationViewModel>.reactive(
      viewModelBuilder: () => BusinessProfileCreationViewModel(),
      onModelReady: (model) async {
        await model.getBusinessCategories();
        listenToFormUpdated(model);
      },
      builder: (context, model, child) => Scaffold(
        body: AuthenticationLayout(
          busy: model.isBusy,
          onBackPressed: model.navigateBack,
          onMainButtonTapped: () => model.saveBusinessData(),
          title: 'Business Profile',
          subtitle: 'Please fill the form below to create a business profile',
          mainButtonTitle: 'Create BUsiness',
          form: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Enter business name',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                controller: businessNameController,
              ),
              verticalSpaceSmall,
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Enter email',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                controller: businessEmailController,
              ),
              verticalSpaceSmall,
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Enter phone number',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                controller: businessMobileController,
              ),
              verticalSpaceSmall,
              DropdownButtonFormField(
                decoration: InputDecoration(
                    labelText: 'Business Category',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                items: model.dropdownItems,
                value: businessCategoryIdController.text.isEmpty
                    ? null
                    : businessCategoryIdController.text,
                onChanged: (value) {
                  businessCategoryIdController.text = value.toString();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
