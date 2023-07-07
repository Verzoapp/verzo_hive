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
import 'package:verzo_one/ui/expenses/expenses_view.dart';

class AddExpensesViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _expenseService = locator<ExpenseService>();
  final _merchantService = locator<MerchantService>();

  bool _recurringValue = false;

  bool get recurringValue => _recurringValue;

  void setRecurring(bool value) {
    _recurringValue = value;
    notifyListeners();
  }

  List<DropdownMenuItem<String>> expenseCategorydropdownItems = [];
  List<DropdownMenuItem<String>> merchantdropdownItems = [];
  List<Merchants> newMerchant = [];
  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }

  Future<List<ExpenseCategory>> getExpenseCategoryWithSets() async {
    final expenseCategories =
        await _expenseService.getExpenseCategoryWithSets();
    expenseCategorydropdownItems = expenseCategories.map((expenseCategory) {
      return DropdownMenuItem<String>(
        value: expenseCategory.id.toString(),
        child: Text(expenseCategory.name),
      );
    }).toList();
    return expenseCategories;
  }

  Future<List<Merchants>> getMerchantsByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';

// Retrieve existing expense categories
    final merchants = await _merchantService.getMerchantsByBusiness(
        businessId: businessIdValue);
    merchantdropdownItems = merchants.map((merchant) {
      return DropdownMenuItem<String>(
        value: merchant.id.toString(),
        child: Text(merchant.name),
      );
    }).toList();
    notifyListeners();

// Add "create new category" dropdown item
    merchantdropdownItems.add(const DropdownMenuItem<String>(
      value: 'new_category',
      child: Text(' +  Create New Merchant'),
    ));

    return merchants;
  }

  void addNewMerchant(List<Merchants> merchant) {
    if (merchant.isNotEmpty) {
      newMerchant.addAll(merchant);
    }
    notifyListeners();
  }

  Future<ExpenseCreationResult> runExpenseCreation() async {
    final prefs = await SharedPreferences.getInstance();
    final businessIdValue = prefs.getString('businessId');
    return _expenseService.createExpenses(
        description: descriptionValue ?? '',
        amount: double.parse(amountValue ?? ''),
        expenseCategoryId: expenseCategoryIdValue ?? '',
        merchantId: merchantIdValue ?? '',
        expenseDate: expenseDateValue ?? '',
        businessId: businessIdValue ?? '',
        reccuring: recurringValue);
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
}
