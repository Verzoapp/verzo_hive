import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/business_profile_service.dart';
import 'package:verzo_one/ui/business_profile_creation/business_profile_creation_view.form.dart';

import '../../app/app.locator.dart';

class BusinessProfileCreationViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final DialogService dialogService = locator<DialogService>();
  final _businessCreationService = locator<BusinessCreationService>();
  List<DropdownMenuItem<String>> businessCategorydropdownItems = [];

  @override
  void setFormStatus() {}

  Future<List<BusinessCategory>> getBusinessCategories() async {
    final businessCategories =
        await _businessCreationService.getBusinessCategories();
    businessCategorydropdownItems = businessCategories.map((businessCategory) {
      return DropdownMenuItem<String>(
        value: businessCategory.id.toString(),
        child: Text(businessCategory.categoryName),
      );
    }).toList();
    return businessCategories;
  }

  Future<BusinessCreationResult> runBusinessCreation() =>
      _businessCreationService.createBusinessProfile(
          businessName: businessNameValue ?? '',
          businessEmail: businessEmailValue ?? '',
          businessMobile: businessMobileValue ?? '',
          businessCategoryId: businessCategoryIdValue ?? '');

  Future saveBusinessData() async {
    final result = await runBusyFuture(runBusinessCreation());

    if (result.business != null) {
      await dialogService.showDialog(
          dialogPlatform: DialogPlatform.Cupertino,
          title: 'Business Profile',
          description: 'Business profile has been sucessfully created',
          barrierDismissible: true);
      // navigate to success route
      navigationService.replaceWith(Routes.loginRoute);
    } else if (result.error != null) {
      setValidationMessage(result.error?.message);
    } else {
      // handle other errors
    }
  }

  void navigateBack() => navigationService.back();
}
