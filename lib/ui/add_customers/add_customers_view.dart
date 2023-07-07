import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:verzo_one/ui/add_customers/add_customers_view.form.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

import './add_customers_view_model.dart';

@FormView(fields: [
  FormTextField(name: 'customerName'),
  FormTextField(name: 'mobile'),
  FormTextField(name: 'email'),
  FormTextField(name: 'address'),
])
class AddCustomersView extends StatelessWidget with $AddCustomersView {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddCustomersViewModel>.reactive(
        viewModelBuilder: () => AddCustomersViewModel(),
        onModelReady: (model) async {
          listenToFormUpdated(model);
        },
        builder: (
          BuildContext context,
          AddCustomersViewModel model,
          Widget? child,
        ) =>
            Scaffold(
              body: AuthenticationLayout(
                busy: model.isBusy,
                validationMessage: model.validationMessage,
                onBackPressed: model.navigateBack,
                onMainButtonTapped: model.saveCustomerData,
                title: 'Create a Customer',
                subtitle: 'Pls fill the form to create a customer',
                mainButtonTitle: 'Add',
                form: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Customer name',
                          labelStyle: ktsFormText,
                          border: defaultFormBorder),
                      keyboardType: TextInputType.name,
                      controller: customerNameController,
                    ),
                    verticalSpaceSmall,
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Customer mobile',
                          labelStyle: ktsFormText,
                          border: defaultFormBorder),
                      keyboardType: TextInputType.number,
                      controller: mobileController,
                    ),
                    verticalSpaceSmall,
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Customer email',
                          labelStyle: ktsFormText,
                          border: defaultFormBorder),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    verticalSpaceSmall,
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Customer address',
                          labelStyle: ktsFormText,
                          border: defaultFormBorder),
                      keyboardType: TextInputType.name,
                      controller: addressController,
                    ),
                  ],
                ),
              ),
            ));
  }
}
