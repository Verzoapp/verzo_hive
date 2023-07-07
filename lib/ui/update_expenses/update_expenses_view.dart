import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/services/expenses_service.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_view.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

import './update_expenses_view_model.dart';
import 'update_expenses_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'updateDescription'),
  FormTextField(name: 'updateAmount'),
  FormTextField(name: 'updateExpenseCategoryId'),
  FormTextField(name: 'updateExpenseDate'),
  FormTextField(name: 'updateMerchantId')
])
class UpdateExpensesView extends StatelessWidget with $UpdateExpensesView {
  final Expenses selectedExpense;
  UpdateExpensesView({
    Key? key,
    required this.selectedExpense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateExpensesViewModel>.reactive(
      viewModelBuilder: () => UpdateExpensesViewModel(expense: selectedExpense),
      onModelReady: (model) {
        model.setSelectedExpense();
        model.getExpenseCategoryWithSets();
        model.getMerchantsByBusiness();
        model.addNewMerchant;
        listenToFormUpdated(model);
      },
      builder: (
        context,
        model,
        child,
      ) =>
          Scaffold(
              body: AuthenticationLayout(
        busy: model.isBusy,
        onBackPressed: model.navigateBack,
        onMainButtonTapped: () => model.updateExpenseData(),
        title: 'Update Expense',
        subtitle: '',
        mainButtonTitle: 'Update',
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
              controller: model.updateDescriptionController,
            ),
            verticalSpaceSmall,
            DropdownButtonFormField(
              decoration: InputDecoration(
                  labelText: ' ExpenseCategory',
                  labelStyle: ktsFormText,
                  border: defaultFormBorder),
              items: model.expenseCategorydropdownItems,
              value: model.updateExpenseCategoryIdController.text.isEmpty
                  ? null
                  : model.updateExpenseCategoryIdController.text,
              onChanged: (value) {
                model.updateExpenseCategoryIdController.text = value.toString();
              },
            ),
            verticalSpaceSmall,
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: ktsFormText,
                  border: defaultFormBorder),
              keyboardType: TextInputType.number,
              controller: model.updateAmountController,
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: model.updateExpenseDateController,
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
                  model.updateExpenseDateController.text = formattedDate;
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
              value: model.updateMerchantIdController.text.isEmpty
                  ? null
                  : model.updateMerchantIdController.text,
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
                  model.updateMerchantIdController.text = value.toString();
                }
              },
            ),
            verticalSpaceSmall,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Recurring',
            //       style: ktsFormText,
            //     ),
            //     // Spacer(),
            //     Switch(
            //       value: model.recurringValue,
            //       onChanged: (value) {
            //         model.setRecurring(value);
            //       },
            //     ),
            //   ],
            // ),
          ],
        ),
      )),
    );
  }
}
