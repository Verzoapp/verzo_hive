import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

import './view_customers_view_model.dart';

class ViewCustomersView extends StatelessWidget {
  final Customers selectedCustomer;

  ViewCustomersView({Key? key, required this.selectedCustomer});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewCustomersViewModel>.reactive(
        viewModelBuilder: () =>
            ViewCustomersViewModel(customer: selectedCustomer),
        onModelReady: (model) async {
          // model.getExpenseById(selectedExpense.id);
        },
        builder: (BuildContext context, ViewCustomersViewModel model,
            Widget? child) {
          return Scaffold(
            body: AuthenticationLayout(
              busy: model.isBusy,
              onMainButtonTapped: model.navigateBack,
              title: 'View Customers',
              subtitle:
                  'This information will be displayed publicly so be careful what you share.',
              mainButtonTitle: 'Done',
              form: Column(
                children: [
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: 'Customer name',
                        labelStyle: ktsFormText,
                        border: defaultFormBorder),
                    keyboardType: TextInputType.name,
                    initialValue: model.customer.name,
                  ),
                  verticalSpaceSmall,
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: 'Customer mobile',
                        labelStyle: ktsFormText,
                        border: defaultFormBorder),
                    keyboardType: TextInputType.number,
                    initialValue: selectedCustomer.mobile,
                  ),
                  verticalSpaceSmall,
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: 'Customer email',
                        labelStyle: ktsFormText,
                        border: defaultFormBorder),
                    keyboardType: TextInputType.emailAddress,
                    initialValue: selectedCustomer.email,
                  ),
                  verticalSpaceSmall,
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: 'Customer address',
                        labelStyle: ktsFormText,
                        border: defaultFormBorder),
                    keyboardType: TextInputType.name,
                    // initialValue: model.customer.address,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
