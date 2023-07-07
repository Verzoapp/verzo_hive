import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/services/expenses_service.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

import './view_expenses_view_model.dart';

class ViewExpensesView extends StatelessWidget {
  final Expenses selectedExpense;

  ViewExpensesView({Key? key, required this.selectedExpense});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewExpensesViewModel>.reactive(
      viewModelBuilder: () => ViewExpensesViewModel(expense: selectedExpense),
      onModelReady: (model) async {
        // model.getExpenseById(selectedExpense.id);
      },
      builder: (
        BuildContext context,
        ViewExpensesViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: AuthenticationLayout(
            busy: model.isBusy,
            onMainButtonTapped: model.navigateBack,
            title: 'View Expense',
            subtitle:
                'This information will be displayed publicly so be careful what you share.',
            mainButtonTitle: 'Done',
            form: Column(
              children: [
                TextFormField(
                  readOnly: true,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  maxLines: 3,
                  decoration: InputDecoration(
                      labelText: 'Expense description',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  keyboardType: TextInputType.name,
                  initialValue: model.expense.description,
                  // initialValue: selectedExpense.description,
                ),
                verticalSpaceSmall,
                TextFormField(
                  readOnly: true,
                  initialValue: selectedExpense.expenseCategoryName,
                  decoration: InputDecoration(
                      labelText: ' ExpenseCategory',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                ),
                verticalSpaceSmall,
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      labelText: 'Amount',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  keyboardType: TextInputType.number,
                  initialValue: selectedExpense.amount.toString(),
                ),
                verticalSpaceSmall,
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      labelText: 'Date',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  keyboardType: TextInputType.datetime,
                  initialValue: selectedExpense.expenseDate,
                ),
                verticalSpaceSmall,
                TextFormField(
                  readOnly: true,
                  initialValue: selectedExpense.merchantName,
                  decoration: InputDecoration(
                      labelText: ' Merchant (Optional)',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
