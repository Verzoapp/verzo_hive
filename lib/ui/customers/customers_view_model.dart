import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/services/invoices_service.dart';

class CustomersViewModel extends FutureViewModel<List<Customers>>
// with ReactiveServiceMixin
{
  final navigationService = locator<NavigationService>();
  final _invoiceService = locator<InvoiceService>();
  // List<Customers> customers = [];
  // List<Customers> filteredCustomers = [];

  // final _filteredCustomers = ReactiveValue<List<Customers>>([]);
  // List<Customers> get filteredCustomers => _filteredCustomers.value;

  // CustomersViewModel() {
  //   listenToReactiveValues([
  //     _filteredCustomers,
  //   ]);
  // }
  // void runFilter(String value) {
  //   // print('Filtering with value: $value');
  //   _filteredCustomers.value = customers
  //       .where((customer) =>
  //           customer.name.toLowerCase().contains(value.toLowerCase()) ||
  //           customer.email.toLowerCase().contains(value.toLowerCase()))
  //       .toList();

  //   // print('Filtered Customers: ${_filteredCustomers.value}');
  //   notifyListeners();
  // }

  @override
  Future<List<Customers>> futureToRun() => getCustomersByBusiness();
  Future<List<Customers>> getCustomersByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';

    // Retrieve existing customers
    final customers = await _invoiceService.getCustomerByBusiness(
        businessId: businessIdValue);
    // customerList = customers;
    // _filteredCustomers.value = customers;
    notifyListeners();

    return customers;
  }

  Future<bool> archiveCustomer(String customerId) async {
    final bool isArchived =
        await _invoiceService.archiveCustomer(customerId: customerId);
    return isArchived;
  }
}
