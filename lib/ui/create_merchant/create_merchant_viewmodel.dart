import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/enums/bottomsheet_type.dart';
import 'package:verzo_one/services/merchant_service.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_view.form.dart';
import 'package:verzo_one/ui/setup_bottom_sheet_ui.dart';

class CreateMerchantViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _createMerchantService = locator<MerchantService>();

  Future<MerchantCreationResult> runMerchantCreation() async {
    final prefs = await SharedPreferences.getInstance();
    final businessIdValue = prefs.getString('id');
    return _createMerchantService.createMerchant(
        name: nameValue ?? '', businessId: businessIdValue ?? '');
  }

  Future saveMerchantData() async {
    final result = await runBusyFuture(runMerchantCreation());

    if (result.merchant != null) {
      // navigate to success route
      navigationService.back();
    } else if (result.error != null) {
      setValidationMessage(result.error?.message);
    } else {
      // handle other errors
    }
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
