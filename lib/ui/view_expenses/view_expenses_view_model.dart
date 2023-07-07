import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/services/expenses_service.dart';

class ViewExpensesViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _expenseService = locator<ExpenseService>();

  late Expenses expense; // Add selectedExpense variable

  // bool? recurringValue;

  ViewExpensesViewModel({required this.expense});

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }

  Future<Expenses> getExpenseById(String expenseId) async {
    final expenses = await _expenseService.getExpenseById(expenseId: expenseId);
    notifyListeners();
    return expenses;
  }

  void navigateBack() => navigationService.back();
}
