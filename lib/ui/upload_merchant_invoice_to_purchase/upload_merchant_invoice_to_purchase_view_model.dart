import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/enums/bottomsheet_type.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/services/purchase_order_service.dart';
import 'package:verzo_one/ui/add_expenses/add_expenses_view.form.dart';
import 'package:verzo_one/ui/create_customer/create_customer_view.form.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_view.form.dart';
import 'package:verzo_one/ui/make_purchase_payment/make_purchase_payment_view.form.dart';
import 'package:verzo_one/ui/setup_bottom_sheet_ui.dart';
import 'package:verzo_one/ui/upload_merchant_invoice_to_purchase/upload_merchant_invoice_to_purchase_view.form.dart';

class UploadMerchantInvoiceToPurchaseViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _purchaseService = locator<PurchaseService>();
  final DialogService dialogService = locator<DialogService>();

  late Purchases purchase;

  UploadMerchantInvoiceToPurchaseViewModel({required this.purchase});

  bool _matchValue = false;

  bool get matchValue => _matchValue;

  void setMatch(bool value) {
    _matchValue = value;
    notifyListeners();
  }

  Future<bool> uploadMerchantInvoiceToPurchase(String purchaseId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String businessIdValue = prefs.getString('businessId') ?? '';

    final bool isPayed = await _purchaseService.uploadMerchantInvoiceToPurchase(
      purchaseId: purchaseId,
      businessId: businessIdValue,
      match: matchValue,
      invoiceDate: invoiceDateValue ?? '',
    );
    return isPayed;
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
