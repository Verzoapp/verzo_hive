import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/product&services_service.dart';

class UpdateProductsServicesViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _createProductService = locator<ProductsxServicesService>();
  late bool isProduct;
  late Items item;
  late final String itemId;

  UpdateProductsServicesViewModel({required this.item}) {
    isProduct = item.type == 'P';
  }

  void setSelectedItem() {
    itemId = item.id;
    // Set the form field values based on the selected expense properties
    updateNameController.text =
        (isProduct ? item.productName : item.serviceName)!;
    updatePriceController.text = item.price.toString();
    updateBasicUnitController.text = item.basicUnit.toString();
    updateProductUnitIdController?.text = item.productUnitId.toString();
    updateServiceUnitIdController?.text = item.serviceUnitId.toString();
    // updateQuantityInStockController.text = item.quantityInStock.toString();

    notifyListeners();
  }

  // void setRecurring(bool value) {
  //   recurringValue = value;
  //   notifyListeners();
  // }

  TextEditingController updateNameController = TextEditingController();
  TextEditingController updatePriceController = TextEditingController();
  TextEditingController updateBasicUnitController = TextEditingController();
  // TextEditingController updateQuantityInStockController =
  //     TextEditingController();
  TextEditingController? updateProductUnitIdController =
      TextEditingController();
  TextEditingController? updateServiceUnitIdController =
      TextEditingController();

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

  Future<ProductUpdateResult> runProductUpdate() async {
    return _createProductService.updateProducts(
      productId: itemId,
      productName: updateNameController.text,
      price: double.parse(updatePriceController.text),
      productUnitId: updateProductUnitIdController?.text,
      basicUnit: double.parse(updateBasicUnitController.text),
      // quantityInStock: double.parse(updateQuantityInStockController.text),
      // reccuring: recurringValue
    );
  }

  Future updateProductData() async {
    final result = await runBusyFuture(runProductUpdate());

    if (result.product != null) {
      // navigate to success route
      navigationService.replaceWith(Routes.productsServicesRoute);
    } else if (result.error != null) {
      setValidationMessage(result.error?.message);
    } else {
      // handle other errors
    }
  }

  Future<ServiceUpdateResult> runServiceUpdate() async {
    return _createProductService.updateServices(
      serviceId: itemId,
      name: updateNameController.text,
      price: double.parse(updatePriceController.text),
      serviceUnitId: updateServiceUnitIdController?.text,
    );
  }

  Future updateServiceData() async {
    final result = await runBusyFuture(runServiceUpdate());

    if (result.service != null) {
      // navigate to success route
      navigationService.replaceWith(Routes.productsServicesRoute);
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
