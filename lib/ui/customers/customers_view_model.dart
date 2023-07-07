import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/services/invoices_service.dart';

class CustomersViewModel extends FutureViewModel<List<Customers>> {
  final navigationService = locator<NavigationService>();
  final _invoiceService = locator<InvoiceService>();
  List<Customers> newCustomer = [];

  @override
  Future<List<Customers>> futureToRun() => getCustomersByBusiness();
  Future<List<Customers>> getCustomersByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';

    // Retrieve existing customers
    final customers = await _invoiceService.getCustomerByBusiness(
        businessId: businessIdValue);
    // customerList = customers;
    // filteredCustomerList = customers;
    notifyListeners();

    return customers;
  }

  Future<bool> archiveCustomer(String customerId) async {
    final bool isArchived =
        await _invoiceService.archiveCustomer(customerId: customerId);
    return isArchived;
  }

  void addNewCustomer(List<Customers> customer) {
    if (customer.isNotEmpty) {
      newCustomer.addAll(customer);
    }
    notifyListeners();
  }
}
