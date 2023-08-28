import 'package:flutter/material.dart';
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

  List<DropdownMenuItem<String>> productUnitdropdownItems = [];
  List<DropdownMenuItem<String>> serviceUnitdropdownItems = [];

  Future<List<ProductUnit>> getProductUnits() async {
    final productUnits = await _createProductService.getProductUnits();
    productUnitdropdownItems = productUnits.map((productUnit) {
      return DropdownMenuItem<String>(
        value: productUnit.id.toString(),
        child: Text(productUnit.unitName),
      );
    }).toList();
    return productUnits;
  }

  Future<List<ServiceUnit>> getServiceUnits() async {
    final serviceUnits = await _createProductService.getServiceUnits();
    serviceUnitdropdownItems = serviceUnits.map((serviceUnit) {
      return DropdownMenuItem<String>(
        value: serviceUnit.id.toString(),
        child: Text(serviceUnit.unitName),
      );
    }).toList();
    return serviceUnits;
  }

  Future<ProductCreationResult> runProductCreation() async {
    final prefs = await SharedPreferences.getInstance();
    final businessIdValue = prefs.getString('id');
    return _createProductService.createProducts(
        productName: productNameValue ?? '',
        businessId: businessIdValue ?? '',
        price: double.parse(priceValue ?? ''),
        basicUnit: double.parse(basicUnitValue ?? ''),
        productUnitId: productUnitIdValue ?? '');
  }

  Future saveProductData() async {
    final result = await runBusyFuture(runProductCreation());

    if (result.product != null) {
      // navigate to success route
      navigationService.replaceWith(Routes.chooseItemRoute);
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
        serviceUnitId: serviceUnitIdValue ?? '');
  }

  Future saveServiceData() async {
    final result = await runBusyFuture(runServiceCreation());

    if (result.service != null) {
      // navigate to success route
      navigationService.replaceWith(Routes.chooseItemRoute);
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
