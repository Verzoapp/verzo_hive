import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/services/purchase_order_service.dart';

class PurchaseOrderViewModel extends FutureViewModel<List<Purchases>> {
  final navigationService = locator<NavigationService>();
  final _purchaseService = locator<PurchaseService>();
  final DialogService dialogService = locator<DialogService>();
  // TextEditingController searchController = TextEditingController();

  @override
  Future<List<Purchases>> futureToRun() => getPurchaseByBusiness();
  Future<List<Purchases>> getPurchaseByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';

    // Retrieve existing customers
    final purchases = await _purchaseService.getPurchaseByBusiness(
        businessId: businessIdValue);
    notifyListeners();
    return purchases;
  }

  Future<bool> archivePurchase(String purchaseId) async {
    final bool isArchived =
        await _purchaseService.archivePurchase(purchaseId: purchaseId);
    if (isArchived) {
      await dialogService.showDialog(
        dialogPlatform: DialogPlatform.Cupertino,
        title: 'Purchase Archived',
        description: 'Purchase has been successfully archived.',
        barrierDismissible: true,
        buttonTitle: 'OK',
      );
      await reloadPurchaseData();
    }
    return isArchived;
  }

  Future<bool> deletePurchase(String purchaseId) async {
    final bool isDeleted =
        await _purchaseService.deletePurchase(purchaseId: purchaseId);
    if (isDeleted) {
      // await futureToRun();
      await dialogService.showDialog(
        dialogPlatform: DialogPlatform.Cupertino,
        title: 'Purchase Deleted',
        description: 'Purchase has been successfully deleted.',
        barrierDismissible: true,
        buttonTitle: 'OK',
      );
    }
    await reloadPurchaseData();

    return isDeleted;
  }

  // List<Purchases> get filteredPurchases {
  //   final query = searchController.text.toLowerCase();
  //   return data
  //           ?.where((purchase) =>
  //               purchase.description.toLowerCase().contains(query) ||
  //               purchase.transactionDate.contains(query))
  //           .toList() ??
  //       [];
  // }

  // Future<void> reloadPurchaseData() async {
  //   getPurchaseByBusiness();
  // }

  Future<void> reloadPurchaseData() async {
    final purchases = await getPurchaseByBusiness();
    // Update the data with the new list of purchases
    data = purchases;
    notifyListeners();
  }
}
