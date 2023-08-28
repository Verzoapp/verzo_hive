// import 'package:pdf/pdf.dart';

import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/services/invoices_service.dart';

class ViewInvoicesViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();

  late Invoices invoice; // Add selectedExpense variable

  // bool? recurringValue;

  ViewInvoicesViewModel({required this.invoice});
  void navigateBack() => navigationService.back();

  // Function to create the printout view
  Widget buildPrintableView() {
    return Column(
        // Create your printout-style content here
        );
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
