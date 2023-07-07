import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/ui/create_customer/create_customer_view.form.dart';

class AddCustomersViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _createCustomerService = locator<InvoiceService>();

  Future<CustomerCreationResult> runCustomerCreation() async {
    final prefs = await SharedPreferences.getInstance();
    final businessIdValue = prefs.getString('id');
    return _createCustomerService.createCustomer(
        name: customerNameValue ?? '',
        mobile: mobileValue ?? '',
        email: emailValue ?? '',
        address: addressValue ?? '',
        businessId: businessIdValue ?? '');
  }

  Future saveCustomerData() async {
    final result = await runBusyFuture(runCustomerCreation());

    if (result.customer != null) {
      // navigate to success route
      navigationService.replaceWith(Routes.customersRoute);
    } else if (result.error != null) {
      setValidationMessage(result.error?.message);
    } else {
      // handle other errors
    }
  }

  void navigateBack() => navigationService.back();

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
