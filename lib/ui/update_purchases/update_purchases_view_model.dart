import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/expenses_service.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/services/merchant_service.dart';
import 'package:verzo_one/services/product&services_service.dart';
import 'package:verzo_one/services/purchase_order_service.dart';
import 'package:verzo_one/ui/shared/styles.dart';

class UpdatePurchasesViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _purchaseService = locator<PurchaseService>();
  final _merchantService = locator<MerchantService>();
  late Purchases purchase;
  late final String purchaseId;

  UpdatePurchasesViewModel({required this.purchase});

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

  List<PurchaseItemDetail> get selectedItems => selectedPurchaseItems;

  void setSelectedPurchase() {
    purchaseId = purchase.id;
    // Set the form field values based on the selected expense properties
    updateDescriptionController.text = purchase.description;
    updateReferenceController.text = purchase.reference!;
    updateMerchantIdController.text = purchase.merchantId;
    updateTransactionDateController.text = purchase.transactionDate;
    selectedPurchaseItems = purchase.purchaseItems;
    calculateTotal();
    notifyListeners();
  }

  TextEditingController updateDescriptionController = TextEditingController();
  TextEditingController updateReferenceController = TextEditingController();
  TextEditingController updateMerchantIdController = TextEditingController();
  TextEditingController updateTransactionDateController =
      TextEditingController();

  List<PurchaseItemDetail> selectedPurchaseItems = [];
  List<Products> newlySelectedPurchaseItems = [];
  double total = 0.00;

  void addselectedItems(List<PurchaseItemDetail> purchaseItems) {
    if (purchaseItems.isNotEmpty) {
      selectedPurchaseItems.addAll(purchaseItems);
    }
    calculateTotal();
    notifyListeners();
  }

  void removeSelectedItem(PurchaseItemDetail purchaseItems) {
    selectedPurchaseItems.remove(purchaseItems);
    calculateTotal();
    notifyListeners();
  }

  void calculateTotal() {
    total = selectedPurchaseItems.fold(0.00, (sum, purchaseItem) {
      return sum + (purchaseItem.unitPrice * (purchaseItem.quantity));
    });
  }

  void openEditBottomSheet(PurchaseItemDetail purchaseItem) {
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
                  initialValue: purchaseItem.unitPrice.toString(),
                  // Handle price input
                  onChanged: (value) {
                    // Update the item price
                    purchaseItem.unitPrice = num.tryParse(value) ?? 0;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                  ),
                  initialValue: purchaseItem.quantity
                      .toString(), // Set the initial value to quantity
                  // Handle quantity input
                  onChanged: (value) {
                    // Update the item quantity
                    purchaseItem.quantity = num.tryParse(value) ?? 1;
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

  List<DropdownMenuItem<String>> merchantdropdownItems = [];
  List<Merchants> newMerchant = [];

  Future<List<Merchants>> getMerchantsByBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('id') ?? '';

// Retrieve existing expense categories
    final merchants = await _merchantService.getMerchantsByBusiness(
        businessId: businessIdValue);
    merchantdropdownItems = merchants.map((merchant) {
      return DropdownMenuItem<String>(
        value: merchant.id.toString(),
        child: Text(merchant.name),
      );
    }).toList();

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

  Future<PurchaseUpdateResult> runPurchaseUpdate() async {
    return _purchaseService.updatePurchases(
        purchaseId: purchaseId,
        description: updateDescriptionController.text,
        merchantId: updateMerchantIdController.text,
        purchaseItems: selectedPurchaseItems,
        transactionDate: updateTransactionDateController.text,
        reference: updateReferenceController.text);
  }

  Future updatePurchaseData() async {
    final result = await runBusyFuture(runPurchaseUpdate());

    if (result.purchase != null) {
      // navigate to success route
      navigationService.replaceWith(Routes.purchaseOrderRoute);
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
