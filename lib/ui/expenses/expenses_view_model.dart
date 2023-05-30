import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/services/expenses_service.dart';

class ExpensesViewModel extends BaseViewModel
    with ReactiveServiceMixin, Initialisable {
  List<Expenses> newExpense = [];
  final navigationService = locator<NavigationService>();
  final _expenseService = locator<ExpenseService>();
  final scrollController = ScrollController();

  final _expenses = ReactiveValue<List<Expenses?>>([]);
  List<Expenses?> get expenses => _expenses.value;
  final _take = ReactiveValue<num>(0);
  num get take => _take.value;
  final _cursor = ReactiveValue<String?>(null);
  String? get cursor => _cursor.value;

  ExpensesViewModel() {
    listenToReactiveValues([_expenses, _take, _cursor]);
  }

  Future<List<Expenses?>> getExpenseByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('id') ?? '';

    // Retrieve existing expense categories
    final expenseList = await _expenseService.getExpenseByBusiness(
      businessId: businessIdValue,
    );
    _expenses.value.addAll(expenseList);
    if (expenseList.isNotEmpty) {
      _cursor.value = '';
      // _cursor.value = expenseList.last.id;
    }
    return _expenses.value;
  }

  void addNewExpense(List<Expenses> expense) {
    if (expense.isNotEmpty) {
      newExpense.addAll(expense);
    }
    notifyListeners();
  }

  // Future<void> deleteExpense() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String expenseId = prefs.getString('expense_id') ?? '';
  //   await _expenseService.deleteExpense(expenseId: expenseId);
  // }

  // Future<void> showDeleteConfirmationDialog(BuildContext context) async {
  //   final confirmed = await showDialog<bool>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Confirm Delete'),
  //         content: Text('Are you sure you want to delete this expense?'),
  //         actions: [
  //           TextButton(
  //             child: Text('No'),
  //             onPressed: () {
  //               Navigator.of(context).pop(false);
  //             },
  //           ),
  //           TextButton(
  //             child: Text('Yes'),
  //             onPressed: () {
  //               Navigator.of(context).pop(true);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );

  //   if (confirmed == true) {
  //     // User confirmed deletion, call the deleteExpense function
  //     deleteExpense();
  //   }
  // }

  @override
  Future<void> initialise() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cursor.value = prefs.getString('cursorId');
    await getExpenseByBusiness();
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        await getExpenseByBusiness();
      }
    });
  }
}
// // class ExpensesViewModel
// //     extends FutureViewModel<PagingController<int, Expenses>> {
// //   final navigationService = locator<NavigationService>();
// //   final _expenseService = locator<ExpenseService>();

// //   @override
// //   Future<PagingController<int, Expenses>> futureToRun() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     String businessIdValue = prefs.getString('id') ?? '';

// //     // Set up the PagingController with page size of 10
// //     final pagingController = PagingController<int, Expenses>(firstPageKey: 0);
// //     pagingController.addPageRequestListener((pageKey) {
// //       // Get the next page of expenses
// //       getExpenseByBusiness(pageKey, businessIdValue).then((expenses) {
// //         if (expenses.isEmpty) {
// //           pagingController.appendLastPage([]);
// //         } else {
// //           final nextPageKey = pageKey + expenses.length;
// //           pagingController.appendPage(expenses, nextPageKey);
// //         }
// //       });
// //     });
// //     return pagingController;
// //   }

// //   Future<List<Expenses>> getExpenseByBusiness(
// //       int offset, String businessId) async {
// //     // Retrieve not more than 10 expenses starting from the offset
// //     final expenses = await _expenseService.getExpenseByBusiness(
// //       businessId: businessId,
// //       limit: 10,
// //       offset: offset,
// //     );
// //     return expenses;
// //   }
// // }

// class ExpensesViewModel extends FutureViewModel {
//   final navigationService = locator<NavigationService>();
//   final _expenseService = locator<ExpenseService>();
//   final scrollController = ScrollController();

//   List<Expenses> expenses = [];

//   Future<List<Expenses>> getExpenseByBusiness() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String businessIdValue = prefs.getString('id') ?? '';

//     // Retrieve existing expense categories
//     final expensesResult =
//         await _expenseService.getExpenseByBusiness(businessId: businessIdValue);
//     expenses = expensesResult;
//     return expensesResult;
//   }

//   // Future<void> fetch() async {
//   //   final list = await getExpenseByBusiness();
//   //   _expenses.addAll(list);
//   // }

//   // @override
//   // void initialise() {
//   //   scrollController.addListener(() async {
//   //     if (scrollController.position.maxScrollExtent ==
//   //         scrollController.offset) {
//   //       await fetch();
//   //     }
//   //   });
//   // }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Future futureToRun() {
//     return getExpenseByBusiness();
//   }
// }

class NameOfClassViewModel extends BaseViewModel {}
