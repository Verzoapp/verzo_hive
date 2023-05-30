import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/product&services_service.dart';
import 'package:verzo_one/ui/add_item/add_item_view.form.dart';

class AddItemViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _createProductService = locator<ProductsxServicesService>();

  bool isProduct = true;
  Future<ProductCreationResult> runProductCreation() async {
    final prefs = await SharedPreferences.getInstance();
    final businessIdValue = prefs.getString('id');
    return _createProductService.createProducts(
        productName: productNameValue ?? '',
        businessId: businessIdValue ?? '',
        price: double.parse(priceValue ?? ''),
        basicUnit: double.parse(basicUnitValue ?? ''),
        quantityInStock: double.parse(quantityInStockValue ?? ''));
  }

  Future saveProductData() async {
    final result = await runBusyFuture(runProductCreation());

    if (result.product != null) {
      // navigate to success route
      navigationService.replaceWith(Routes.addInvoiceRoute);
    } else if (result.error != null) {
      setValidationMessage(result.error?.message);
    } else {
      // handle other errors
    }
  }

  Future<ServiceCreationResult> runServiceCreation() async {
    final prefs = await SharedPreferences.getInstance();
    final businessIdValue = prefs.getString('id');
    return _createProductService.createServices(
      name: productNameValue ?? '',
      businessId: businessIdValue ?? '',
      price: double.parse(priceValue ?? ''),
    );
  }

  Future saveServiceData() async {
    final result = await runBusyFuture(runServiceCreation());

    if (result.service != null) {
      // navigate to success route
      navigationService.replaceWith(Routes.addInvoiceRoute);
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
