import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/services/product&services_service.dart';

class ChoosePurchaseItemViewModel extends FutureViewModel<List<Products>> {
  final navigationService = locator<NavigationService>();
  final _productservicesService = locator<ProductsxServicesService>();

  List<Products> purchaseItems = [];
  List<Products> selectedPurchaseItems = [];
  List<Products> newPurchaseItem = [];
  @override
  Future<List<Products>> futureToRun() => getProductsByBusiness();
  Future<List<Products>> getProductsByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';

    // Retrieve existing products/services
    final products = await _productservicesService.getProductsByBusiness(
        businessId: businessIdValue);

    notifyListeners();

    return products;
  }

  void addNewItem(List<Products> purchaseItem) {
    if (purchaseItem.isNotEmpty) {
      newPurchaseItem.addAll(purchaseItem);
    }

    notifyListeners();
  }

  void navigateBack() => navigationService.back();
}
