import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/expenses_service.dart';

class ExpensesViewModel extends FutureViewModel<List<Expenses>> {
  List<Expenses> newExpense = [];
  final navigationService = locator<NavigationService>();
  final _expenseService = locator<ExpenseService>();
  // final scrollController = ScrollController();

  // final _expenses = ReactiveValue<List<Expenses>>([]);
  // List<Expenses> get expenses => _expenses.value;
  // final _take = ReactiveValue<num>(10);
  // num get take => _take.value;
  // final _cursor = ReactiveValue<String?>(null);
  // String? get cursor => _cursor.value;

  // ExpensesViewModel() {
  //   listenToReactiveValues([_expenses, _take, _cursor]);
  // }

  // Future<List<Expenses>> getExpenseByBusiness() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String businessIdValue = prefs.getString('businessId') ?? '';

  //   // Retrieve existing expense categories
  //   final expenseList = await _expenseService.getExpenseByBusiness(
  //       businessId: businessIdValue, take: _take.value);
  //   _expenses.value.addAll(expenseList);
  //   // if (expenseList.isNotEmpty) {
  //   //   _cursor.value = '';
  //   //   // _cursor.value = expenseList.last.id;
  //   // // }
  //   // notifyListeners();
  //   return _expenses.value;
  // }
  @override
  Future<List<Expenses>> futureToRun() => getExpenseByBusiness();

  Future<List<Expenses>> getExpenseByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';

    // Retrieve existing expense categories
    final expenses =
        await _expenseService.getExpenseByBusiness(businessId: businessIdValue);
    return expenses;
  }

  Future<bool> archiveExpense(String expenseId) async {
    final bool isArchived =
        await _expenseService.archiveExpense(expenseId: expenseId);
    return isArchived;
  }

  // void addNewExpense(List<Expenses> expense) {
  //   if (expense.isNotEmpty) {
  //     newExpense.addAll(expense);
  //   }
  //   notifyListeners();
  // }
}
