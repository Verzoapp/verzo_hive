import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';

import 'package:verzo_one/services/invoices_service.dart';

class ViewCustomersViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _invoiceService = locator<InvoiceService>();

  late Customers customer; // Add selectedExpense variable

  // bool? recurringValue;

  ViewCustomersViewModel({required this.customer});

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }

  // Future<Customers> getExpenseById(String expenseId) async {
  //   final customers =
  //       await _invoiceService.getExpenseById(expenseId: expenseId);
  //   notifyListeners();
  //   return customers;
  // }

  void navigateBack() => navigationService.back();
}
