import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/services/purchase_order_service.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';
// import 'package:pdf/widgets.dart' as pw;

import 'view_purchase_view_model.dart';

class ViewPurchaseView extends StatelessWidget {
  final Purchases selectedPurchase;

  ViewPurchaseView({Key? key, required this.selectedPurchase});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewPurchaseViewModel>.reactive(
      viewModelBuilder: () => ViewPurchaseViewModel(purchase: selectedPurchase),
      onModelReady: (ViewPurchaseViewModel model) async {
        // await model.generateInvoicePdf(selectedInvoice);
      },
      builder: (
        BuildContext context,
        ViewPurchaseViewModel model,
        Widget? child,
      ) {
        return Scaffold(
            body: AuthenticationLayout(
                busy: model.isBusy,
                title: 'View Purchase',
                subtitle:
                    'This information will be displayed publicly so be careful what you share.',
                mainButtonTitle: 'Done',
                onMainButtonTapped: model.navigateBack,
                secondaryButtonTitle: 'More Actions',
                onSecondaryButtonTapped: model.secondaryButtonPressed,
                form: Column(
                  children: [
                    // Use the printout view created in the ViewModel
                    RepaintBoundary(
                      child: model.buildPrintableView(),
                    ),
                    // Add buttons for saving to PDF and sending if needed
                  ],
                )));
      },
    );
  }
}
