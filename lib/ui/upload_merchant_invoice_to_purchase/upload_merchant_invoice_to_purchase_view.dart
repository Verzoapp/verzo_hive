import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/services/purchase_order_service.dart';
import 'package:verzo_one/ui/create_customer/create_customer_view.form.dart';
import 'package:verzo_one/ui/create_customer/create_customer_view_model.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_view.form.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_viewmodel.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/make_purchase_payment/make_purchase_payment_view.form.dart';
import 'package:verzo_one/ui/make_purchase_payment/make_purchase_payment_view_model.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';
import 'package:verzo_one/ui/upload_merchant_invoice_to_purchase/upload_merchant_invoice_to_purchase_view_model.dart';

import 'upload_merchant_invoice_to_purchase_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'invoiceDate'),
])
class UploadMerchantInvoiceToPurchaseView extends StatelessWidget
    with $UploadMerchantInvoiceToPurchaseView {
  final Purchases selectedPurchase;
  UploadMerchantInvoiceToPurchaseView({
    Key? key,
    required this.selectedPurchase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UploadMerchantInvoiceToPurchaseViewModel>.reactive(
      viewModelBuilder: () =>
          UploadMerchantInvoiceToPurchaseViewModel(purchase: selectedPurchase),
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: [
              Text(
                "Upload Merchant Invoice",
                style: ktsHeaderText,
              ),
              verticalSpaceSmall,
              Text(
                "Pls fill the form to upload merchant invoice to this purchase",
                style: ktsParagraphText,
              ),
              verticalSpaceSmall,
              TextFormField(
                controller: invoiceDateController,
                decoration: InputDecoration(
                    labelText: 'Transaction Date',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                keyboardType: TextInputType.datetime,
                onTap: () async {
                  DateTime? pickeddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 5),
                    lastDate: DateTime(DateTime.now().year + 5),
                  );
                  if (pickeddate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickeddate);
                    invoiceDateController.text = formattedDate;
                  }
                },
              ),
              verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Match',
                    style: ktsFormText,
                  ),
                  // Spacer(),
                  Switch(
                    value: model.matchValue,
                    onChanged: (value) {
                      model.setMatch(value);
                    },
                  ),
                ],
              ),
              verticalSpaceLarge,
              GestureDetector(
                onTap: () async {
                  final DialogResponse? response = await model.dialogService
                      .showConfirmationDialog(
                          dialogPlatform: DialogPlatform.Cupertino,
                          title: 'Upload Merchant Invoice',
                          description:
                              'Are you sure you want to upload merchant invoice to this purchase?',
                          barrierDismissible: true,
                          cancelTitle: 'Cancel',
                          confirmationTitle: 'Ok');
                  if (response?.confirmed == true) {
                    // Call the PurchasePayment function
                    bool uploadSuccessful = await model
                        .uploadMerchantInvoiceToPurchase(model.purchase.id);
                    if (uploadSuccessful) {
                      // Payment was successful, handle further actions if needed
                      await model.dialogService.showDialog(
                          dialogPlatform: DialogPlatform.Cupertino,
                          title: 'Upload Merchant Invoice',
                          description:
                              'Merchant Invoice successfully uploaded to this purchase',
                          barrierDismissible: true,
                          buttonTitle: 'OK');
                      Navigator.pop(
                          context); // Close the bottom sheet or dialog
                    }
                  }
                  // Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: defaultBorderRadius,
                    color: kcPrimaryColor,
                  ),
                  child: model.isBusy
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                      : Text(
                          "Upload",
                          style: ktsButtonText,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
