import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/services/expenses_service.dart';

// class ExpensesViewModel
//     extends FutureViewModel<PagingController<int, Expenses>> {
//   final navigationService = locator<NavigationService>();
//   final _expenseService = locator<ExpenseService>();

//   @override
//   Future<PagingController<int, Expenses>> futureToRun() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String businessIdValue = prefs.getString('id') ?? '';

//     // Set up the PagingController with page size of 10
//     final pagingController = PagingController<int, Expenses>(firstPageKey: 0);
//     pagingController.addPageRequestListener((pageKey) {
//       // Get the next page of expenses
//       getExpenseByBusiness(pageKey, businessIdValue).then((expenses) {
//         if (expenses.isEmpty) {
//           pagingController.appendLastPage([]);
//         } else {
//           final nextPageKey = pageKey + expenses.length;
//           pagingController.appendPage(expenses, nextPageKey);
//         }
//       });
//     });
//     return pagingController;
//   }

//   Future<List<Expenses>> getExpenseByBusiness(
//       int offset, String businessId) async {
//     // Retrieve not more than 10 expenses starting from the offset
//     final expenses = await _expenseService.getExpenseByBusiness(
//       businessId: businessId,
//       limit: 10,
//       offset: offset,
//     );
//     return expenses;
//   }
// }

class ExpensesViewModel extends FutureViewModel {
  final navigationService = locator<NavigationService>();
  final _expenseService = locator<ExpenseService>();
  final scrollController = ScrollController();

  List<Expenses> expenses = [];

  Future<List<Expenses>> getExpenseByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('id') ?? '';

    // Retrieve existing expense categories
    final expensesResult =
        await _expenseService.getExpenseByBusiness(businessId: businessIdValue);
    expenses = expensesResult;
    return expensesResult;
  }

  // Future<void> fetch() async {
  //   final list = await getExpenseByBusiness();
  //   _expenses.addAll(list);
  // }

  // @override
  // void initialise() {
  //   scrollController.addListener(() async {
  //     if (scrollController.position.maxScrollExtent ==
  //         scrollController.offset) {
  //       await fetch();
  //     }
  //   });
  // }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Future futureToRun() {
    return getExpenseByBusiness();
  }
}
