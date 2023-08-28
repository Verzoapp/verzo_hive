import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/expenses_service.dart';
import 'package:verzo_one/services/invoices_service.dart';

class UpdateCustomersViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _invoiceService = locator<InvoiceService>();

  late Customers customer;
  late final String customerId;

  UpdateCustomersViewModel({required this.customer});

  void setSelectedCustomer() {
    customerId = customer.id;
    // Set the form field values based on the selected expense properties
    updateCustomerNameController.text = customer.name;
    updateCustomerEmailController.text = customer.email;
    updateCustomerMobileController.text = customer.mobile;
    updateCustomerAddressController.text = customer.address!;
    notifyListeners();
  }

  TextEditingController updateCustomerNameController = TextEditingController();
  TextEditingController updateCustomerEmailController = TextEditingController();
  TextEditingController updateCustomerMobileController =
      TextEditingController();
  TextEditingController updateCustomerAddressController =
      TextEditingController();

  Future<CustomerUpdateResult> runCustomerUpdate() async {
    return _invoiceService.updateCustomers(
        customerId: customerId,
        name: updateCustomerNameController.text,
        mobile: updateCustomerMobileController.text,
        address: updateCustomerAddressController.text,
        email: updateCustomerEmailController.text);
  }

  Future updateCustomerData() async {
    final result = await runBusyFuture(runCustomerUpdate());

    if (result.customer != null) {
      // navigate to success route
      navigationService.replaceWith(Routes.customersRoute);
    } else if (result.error != null) {
      setValidationMessage(result.error?.message);
    } else {
      // handle other errors
    }
  }

  @override
  void setFormStatus() {}

  void navigateBack() => navigationService.back();
}
