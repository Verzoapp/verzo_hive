import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

import './update_customers_view_model.dart';

class UpdateCustomersView extends StatelessWidget {
  final Customers selectedCustomer;
  UpdateCustomersView({
    Key? key,
    required this.selectedCustomer,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateCustomersViewModel>.reactive(
      viewModelBuilder: () =>
          UpdateCustomersViewModel(customer: selectedCustomer),
      onModelReady: (UpdateCustomersViewModel model) async {
        model.setSelectedCustomer();
      },
      builder: (
        BuildContext context,
        UpdateCustomersViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: AuthenticationLayout(
            busy: model.isBusy,
            onBackPressed: model.navigateBack,
            onMainButtonTapped: model.updateCustomerData,
            title: 'Update Customer',
            subtitle: 'Make changes to this customer',
            mainButtonTitle: 'Save',
            form: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Customer name',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  keyboardType: TextInputType.name,
                  controller: model.updateCustomerNameController,
                ),
                verticalSpaceSmall,
                TextFormField(
                  controller: model.updateCustomerMobileController,
                  decoration: InputDecoration(
                      labelText: 'Customer mobile',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  keyboardType: TextInputType.number,
                ),
                verticalSpaceSmall,
                TextFormField(
                  controller: model.updateCustomerEmailController,
                  decoration: InputDecoration(
                      labelText: 'Customer email',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  keyboardType: TextInputType.emailAddress,
                ),
                verticalSpaceSmall,
                TextFormField(
                  controller: model.updateCustomerAddressController,
                  decoration: InputDecoration(
                      labelText: 'Customer address',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  keyboardType: TextInputType.name,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
