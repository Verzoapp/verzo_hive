import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/services/product&services_service.dart';

class ChooseItemViewModel extends FutureViewModel<List<Items>> {
  final navigationService = locator<NavigationService>();
  final _productservicesService = locator<ProductsxServicesService>();

  List<Items> items = [];
  List<Items> selectedItems = [];
  List<Items> newItem = [];
  @override
  Future<List<Items>> futureToRun() => getProductOrServiceByBusiness();
  Future<List<Items>> getProductOrServiceByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';

    // Retrieve existing products/services
    final productsorservices = await _productservicesService
        .getProductOrServiceByBusiness(businessId: businessIdValue);
    items = productsorservices;
    notifyListeners();

    return items;
  }

  void addNewItem(List<Items> item) {
    if (item.isNotEmpty) {
      newItem.addAll(item);
    }

    notifyListeners();
  }

  void navigateBack() => navigationService.back();
}
