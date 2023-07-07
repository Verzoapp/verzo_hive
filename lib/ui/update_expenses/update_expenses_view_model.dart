import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/expenses_service.dart';
import 'package:verzo_one/services/merchant_service.dart';
import 'package:verzo_one/ui/update_expenses/update_expenses_view.form.dart';

class UpdateExpensesViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _expenseService = locator<ExpenseService>();
  final _merchantService = locator<MerchantService>();

  late Expenses expense; // Add selectedExpense variable
  late String expenseId;
  // bool? recurringValue;

  UpdateExpensesViewModel({required Expenses expense});

  void setSelectedExpense() {
    expenseId = expense.id;
    // Set the form field values based on the selected expense properties
    updateDescriptionController.text = expense.description;
    updateAmountController.text = expense.amount.toString();
    updateExpenseDateController.text = expense.expenseDate;
    updateExpenseCategoryIdController.text = expense.expenseCategoryId;
    updateMerchantIdController.text = expense.merchantId ?? '';
    // recurringValue = expense.recurring;
    notifyListeners();
  }

  // void setRecurring(bool value) {
  //   recurringValue = value;
  //   notifyListeners();
  // }

  TextEditingController updateDescriptionController = TextEditingController();
  TextEditingController updateAmountController = TextEditingController();
  TextEditingController updateExpenseDateController = TextEditingController();
  TextEditingController updateMerchantIdController = TextEditingController();
  TextEditingController updateExpenseCategoryIdController =
      TextEditingController();

  List<DropdownMenuItem<String>> expenseCategorydropdownItems = [];
  List<DropdownMenuItem<String>> merchantdropdownItems = [];
  List<Merchants> newMerchant = [];

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

  Future<ExpenseUpdateResult> runExpenseUpdate() async {
    return _expenseService.updateExpenses(
      expenseId: expenseId,
      description: updateDescriptionController.text,
      amount: double.parse(updateAmountController.text),
      expenseCategoryId: updateExpenseCategoryIdController.text,
      merchantId: updateMerchantIdController.text,
      expenseDate: updateExpenseDateController.text,
      // reccuring: recurringValue
    );
  }

  Future updateExpenseData() async {
    final result = await runBusyFuture(runExpenseUpdate());

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
  void setFormStatus() {}
}
