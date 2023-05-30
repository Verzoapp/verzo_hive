// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_services/src/snackbar/snackbar_service.dart';

import '../services/authentication_service.dart';
import '../services/business_profile_service.dart';
import '../services/expenses_service.dart';
import '../services/invoices_service.dart';
import '../services/merchant_service.dart';
import '../services/otp_verification_service.dart';
import '../services/product&services_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerSingleton(AuthenticationService());
  locator.registerSingleton(OTPVerificationService());
  locator.registerSingleton(MerchantService());
  locator.registerSingleton(BusinessCreationService());
  locator.registerSingleton(ExpenseService());
  locator.registerSingleton(InvoiceService());
  locator.registerSingleton(ProductsxServicesService());
}
