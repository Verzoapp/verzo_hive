import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/expenses_service.dart';
import 'package:verzo_one/services/merchant_service.dart';
import 'package:verzo_one/ui/add_expenses/add_expenses_view.form.dart';

class AddExpensesViewModel extends FormViewModel with Initialisable {
  final navigationService = locator<NavigationService>();
  final _expenseService = locator<ExpenseService>();
  final _merchantService = locator<MerchantService>();

  List<DropdownMenuItem<String>> expenseCategorydropdownItems = [];
  List<DropdownMenuItem<String>> merchantdropdownItems = [];

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }

  Future<Merchants> getMerchantsByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('id') ?? '';

// Retrieve existing expense categories
    final merchants = await _merchantService.getMerchantsByBusiness(
        businessId: businessIdValue);
    merchantdropdownItems = merchants.map((merchant) {
      return DropdownMenuItem<String>(
        value: merchant.id.toString(),
        child: Text(merchant.name),
      );
    }).toList();

// Add "create new category" dropdown item
    merchantdropdownItems.add(const DropdownMenuItem<String>(
      value: 'new_category',
      child: Text(' +  Create New Merchant'),
    ));

    return merchants.first;
  }

  Future<ExpenseCategory> getExpenseCategoriesByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('id') ?? '';

    // Retrieve existing expense categories
    final expenseCategories = await _expenseService
        .getExpenseCategoryByBusiness(businessId: businessIdValue);
    expenseCategorydropdownItems = expenseCategories.map((expenseCategory) {
      return DropdownMenuItem<String>(
        value: expenseCategory.id.toString(),
        child: Text(expenseCategory.name),
      );
    }).toList();

    // Add "create new category" dropdown item
    expenseCategorydropdownItems.add(const DropdownMenuItem<String>(
      value: 'new_category',
      child: Text(' + Create New Category'),
    ));

    return expenseCategories.first;
  }

  Future<ExpenseCreationResult> runExpenseCreation() async {
    final prefs = await SharedPreferences.getInstance();
    final businessIdValue = prefs.getString('id');
    return _expenseService.createExpenses(
        description: descriptionValue ?? '',
        amount: double.parse(amountValue ?? ''),
        expenseCategoryId: expenseCategoryIdValue ?? '',
        merchantId: merchantIdValue ?? '',
        expenseDate: expenseDateValue ?? '',
        businessId: businessIdValue ?? '');
  }

  Future saveExpenseData() async {
    final result = await runBusyFuture(runExpenseCreation());

    if (result.expense != null) {
      // navigate to success route
      navigationService.replaceWith(Routes.expensesRoute);
    } else if (result.error != null) {
      setValidationMessage(result.error?.message);
    } else {
      // handle other errors
    }
  }

  void navigateBack() => navigationService.back();

  @override
  Future<void> initialise() async {
    await getMerchantsByBusiness();
    // TODO: implement initialise
  }
}
