import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/business_profile_creation_service.dart';
import 'package:verzo_one/ui/business_profile_creation/business_profile_creation_view.form.dart';

import '../../app/app.locator.dart';

class BusinessProfileCreationViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _businessCreationService = locator<BusinessCreationService>();

  @override
  void setFormStatus() {}

  Future<BusinessCreationResult> runBusinessCreation() =>
      _businessCreationService.createBusinessProfile(
          businessName: businessNameValue ?? '',
          businessEmail: businessEmailValue ?? '',
          businessMobile: businessMobileValue ?? '',
          businessCategoryId: businessCategoryIdValue ?? '');

  Future saveData() async {
    final result = await runBusyFuture(runBusinessCreation());

    if (result.business != null) {
      // navigate to success route
      navigationService.replaceWith(Routes.dashboardRoute);
    } else if (result.error != null) {
      setValidationMessage(result.error?.message);
    } else {
      // handle other errors
    }
  }

  void navigateBack() => navigationService.back();
}
