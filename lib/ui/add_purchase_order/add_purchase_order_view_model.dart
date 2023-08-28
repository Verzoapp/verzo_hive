import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/merchant_service.dart';
import 'package:verzo_one/services/product&services_service.dart';
import 'package:verzo_one/services/purchase_order_service.dart';
import 'package:verzo_one/ui/add_purchase_order/add_purchase_order_view.form.dart';
import 'package:verzo_one/ui/shared/styles.dart';

class AddPurchaseOrderViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _merchantService = locator<MerchantService>();
  final _purchaseService = locator<PurchaseService>();
  List<Products> selectedPurchaseItems = [];
  List<Products> newlySelectedPurchaseItems = [];
  double total = 0.00;

  List<PurchaseItemDetail> convertProductsToPurchaseItemDetails(
      List<Products> purchaseItems) {
    List<PurchaseItemDetail> purchaseItemDetails = [];

    for (int i = 0; i < purchaseItems.length; i++) {
      Products purchaseitem = purchaseItems[i];
      PurchaseItemDetail purchaseItemDetail = PurchaseItemDetail(
          id: '',
          productId: purchaseitem.id,
          unitPrice: purchaseitem.price,
          index: i + 1,
          quantity: purchaseitem.quantity,
          itemDescription: purchaseitem.productName);
      purchaseItemDetails.add(purchaseItemDetail);
    }

    return purchaseItemDetails;
  }

  List<DropdownMenuItem<String>> merchantdropdownItems = [];
  List<Merchants> newMerchant = [];
  void addselectedItems(List<Products> purchaseItems) {
    if (purchaseItems.isNotEmpty) {
      selectedPurchaseItems.addAll(purchaseItems);
    }
    calculateTotal();
    notifyListeners();
  }

  void removeSelectedItem(Products purchaseItems) {
    selectedPurchaseItems.remove(purchaseItems);
    calculateTotal();
    notifyListeners();
  }

  void openEditBottomSheet(Products purchaseItem) {
    showModalBottomSheet(
      context: navigationService.navigatorKey!.currentContext!,
      builder: (BuildContext context) {
        num quantity = 1;
        return ListView(shrinkWrap: true, children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Edit Purchase Item', style: ktsHeaderText),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Unit Price',
                  ),
                  initialValue: purchaseItem.price.toString(),
                  // Handle price input
                  onChanged: (value) {
                    // Update the item price
                    num newPrice = num.tryParse(value) ?? 0;
                    purchaseItem.price = newPrice;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                  ),
                  initialValue:
                      quantity.toString(), // Set the initial value to quantity
                  // Handle quantity input
                  onChanged: (value) {
                    // Update the item quantity
                    num newQuantity = num.tryParse(value) ?? 1;
                    purchaseItem.quantity = newQuantity;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Save the changes and close the bottom sheet
                    calculateTotal();
                    notifyListeners();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save',
                    style: ktsButtonText,
                  ),
                ),
              ],
            ),
          ),
        ]);
      },
    );
  }

  void calculateTotal() {
    total = selectedPurchaseItems.fold(0.00, (sum, purchaseItem) {
      return sum + (purchaseItem.price * (purchaseItem.quantity));
    });
  }

  Future<List<Merchants>> getMerchantsByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';

// Retrieve existing expense categories
    final merchants = await _merchantService.getMerchantsByBusiness(
        businessId: businessIdValue);
    merchantdropdownItems = merchants.map((merchant) {
      return DropdownMenuItem<String>(
        value: merchant.id.toString(),
        child: Text(merchant.name),
      );
    }).toList();
    notifyListeners();

// Add "create new category" dropdown item
    merchantdropdownItems.add(const DropdownMenuItem<String>(
      value: 'new_category',
      child: Text(' +  Create New Merchant'),
    ));

    return merchants;
  }

  void addNewMerchant(List<Merchants> merchant) {
    if (merchant.isNotEmpty) {
      newMerchant.addAll(merchant);
    }
    notifyListeners();
  }

  Future<PurchaseCreationResult> runPurchaseCreation() async {
    final prefs = await SharedPreferences.getInstance();
    final businessIdValue = prefs.getString('businessId');
    return _purchaseService.createPurchaseEntry(
        description: descriptionValue ?? '',
        businessId: businessIdValue ?? '',
        purchaseItems:
            convertProductsToPurchaseItemDetails(selectedPurchaseItems),
        transactionDate: transactionDateValue ?? '',
        reference: referenceValue ?? '',
        merchantId: merchantIdValue ?? '');
  }

  Future savePurchaseData() async {
    final result = await runBusyFuture(runPurchaseCreation());

    if (result.purchase != null) {
      // navigate to success route
      navigationService.replaceWith(Routes.purchaseOrderRoute);
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
