import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/enums/bottomsheet_type.dart';
import 'package:verzo_one/services/expenses_service.dart';
import 'package:verzo_one/ui/add_expenses/add_expenses_view.form.dart';
import 'package:verzo_one/ui/add_expenses/add_expenses_view_model.dart';
import 'package:verzo_one/ui/add_invoices/add_invoices_view.form.dart';
import 'package:verzo_one/ui/add_invoices/add_invoices_view_model.dart';
import 'package:verzo_one/ui/create_customer/create_customer_view.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_view.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_view.form.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/setup_bottom_sheet_ui.dart';

import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

@FormView(
    fields: [FormTextField(name: 'customerId'), FormTextField(name: 'item')])
class AddInvoicesView extends StatelessWidget with $AddInvoicesView {
  AddInvoicesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddInvoicesViewModel>.reactive(
      viewModelBuilder: () => AddInvoicesViewModel(),
      onModelReady: (model) async {
        await model.getCustomersByBusiness();
        listenToFormUpdated(model);
      },
      builder: (context, model, child) => Scaffold(
        body: AuthenticationLayout(
          busy: model.isBusy,
          onBackPressed: model.navigateBack,
          onMainButtonTapped: () => model.saveInvoiceData(),
          title: 'Add Invoice',
          subtitle: 'Please fill the form below to create an invoice',
          mainButtonTitle: 'Add',
          form: Column(
            children: [
              // DropdownButtonFormField(
              //   decoration: InputDecoration(
              //       labelText: ' ExpenseCategory',
              //       labelStyle: ktsFormText,
              //       border: defaultFormBorder),
              //   items: model.expensedropdownItems,
              //   value: expenseCategoryIdController.text.isEmpty
              //       ? null
              //       : expenseCategoryIdController.text,
              //   onChanged: (value) {
              //     expenseCategoryIdController.text = value.toString();
              //   },
              // ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    labelText: ' Customer',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                items: model.customerdropdownItems,
                value: customerIdController.text.isEmpty
                    ? null
                    : customerIdController.text,
                onChanged: (value) {
                  if (value == 'new_category') {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return CreateCustomerView();
                      },
                    ).whenComplete(() {
                      // reset the `_isCreatingMerchant` flag when the bottom sheet is closed
                    });
                  } else {
                    customerIdController.text = value.toString();
                  }
                },
              ),
              verticalSpaceSmall,
              DropdownButtonFormField(
                decoration: InputDecoration(
                    labelText: 'Item',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                items: model.productorservicedropdownItems,
                value: itemController.text.isEmpty ? null : itemController.text,
                onChanged: (value) {
                  itemController.text = value.toString();
                },
              ),
              TextFormField(
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxLines: 3,
                decoration: InputDecoration(
                    labelText: 'Items',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                keyboardType: TextInputType.name,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            fixedColor: kcPrimaryColor,
            iconSize: 24,
            showUnselectedLabels: true,
            unselectedItemColor: kcTextColorLight,
            currentIndex: 3,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'Sales'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'Expenses'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long), label: 'Invoicing')
            ]),
      ),
    );
  }
}
