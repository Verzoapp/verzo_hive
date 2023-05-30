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
import 'package:verzo_one/ui/create_merchant/create_merchant_view.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_view.form.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/setup_bottom_sheet_ui.dart';

import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

@FormView(fields: [
  FormTextField(name: 'description'),
  FormTextField(name: 'amount'),
  FormTextField(name: 'expenseCategoryId'),
  FormTextField(name: 'expenseDate'),
  FormTextField(name: 'merchantId')
])
class AddExpensesView extends StatelessWidget with $AddExpensesView {
  AddExpensesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddExpensesViewModel>.reactive(
      viewModelBuilder: () => AddExpensesViewModel(),
      onModelReady: (model) async {
        model.getExpenseCategoryWithSets();
        model.getMerchantsByBusiness();
        model.addNewMerchant;
        listenToFormUpdated(model);
      },
      builder: (context, model, child) => Scaffold(
        body: AuthenticationLayout(
          busy: model.isBusy,
          onBackPressed: model.navigateBack,
          onMainButtonTapped: () => model.saveExpenseData(),
          title: 'Add Expense',
          subtitle: 'Please fill the form below to create an expense',
          mainButtonTitle: 'Add',
          form: Column(
            children: [
              TextFormField(
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxLines: 3,
                decoration: InputDecoration(
                    labelText: 'Expense description',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                keyboardType: TextInputType.name,
                controller: descriptionController,
              ),
              verticalSpaceSmall,
              DropdownButtonFormField(
                decoration: InputDecoration(
                    labelText: ' ExpenseCategory',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                items: model.expenseCategorydropdownItems,
                value: expenseCategoryIdController.text.isEmpty
                    ? null
                    : expenseCategoryIdController.text,
                onChanged: (value) {
                  expenseCategoryIdController.text = value.toString();
                },
              ),
              verticalSpaceSmall,
              TextFormField(
                // inputFormatters: [
                //   FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                //   TextInputFormatter.withFunction((oldValue, newValue) {
                //     final doubleValue = double.tryParse(newValue.text);
                //     if (doubleValue != null) {
                //       final newAmount =
                //           NumberFormat.currency(locale: 'en_US', symbol: '\$')
                //               .format(doubleValue);
                //       amountController.value = amountController.value.copyWith(
                //         text: newAmount,
                //         selection:
                //             TextSelection.collapsed(offset: newAmount.length),
                //       );
                //     }
                //   }),
                // ],
                decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                keyboardType: TextInputType.number,
                controller: amountController,
              ),
              verticalSpaceSmall,
              TextFormField(
                controller: expenseDateController,
                decoration: InputDecoration(
                    labelText: 'Date',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                keyboardType: TextInputType.datetime,
                onTap: () async {
                  DateTime? pickeddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 5),
                    lastDate: DateTime(DateTime.now().year + 5),
                  );
                  if (pickeddate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickeddate);
                    expenseDateController.text = formattedDate;
                  }
                },
              ),
              verticalSpaceSmall,
              DropdownButtonFormField(
                decoration: InputDecoration(
                    labelText: ' Merchant',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                items: model.merchantdropdownItems,
                value: merchantIdController.text.isEmpty
                    ? null
                    : merchantIdController.text,
                onChanged: (value) async {
                  if (value == 'new_category') {
                    await showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return CreateMerchantView();
                      },
                    ).whenComplete(() async {
                      await model.getMerchantsByBusiness();

                      // reset the `_isCreatingMerchant` flag when the bottom sheet is closed
                    });
                  } else {
                    merchantIdController.text = value.toString();
                  }
                },
              ),
              verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recurring',
                    style: ktsFormText,
                  ),
                  // Spacer(),
                  Switch(
                    value: model.recurringValue,
                    onChanged: (value) {
                      model.setRecurring(value);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //     type: BottomNavigationBarType.fixed,
        //     fixedColor: kcPrimaryColor,
        //     iconSize: 24,
        //     showUnselectedLabels: true,
        //     unselectedItemColor: kcTextColorLight,
        //     currentIndex: 2,
        //     items: const <BottomNavigationBarItem>[
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.home),
        //         label: 'Home',
        //       ),
        //       BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'Sales'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.shopping_cart), label: 'Expenses'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.receipt_long), label: 'Invoicing')
        //     ]),
      ),
    );
  }
}
