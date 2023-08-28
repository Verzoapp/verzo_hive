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

@FormView(fields: [
  FormTextField(name: 'paymentDescription'),
  FormTextField(name: 'paymentReference'),
  FormTextField(name: 'paymentTransactionDate'),
  FormTextField(name: 'paymentTotal'),
])
class MakePurchasePaymentView extends StatelessWidget
    with $MakePurchasePaymentView {
  final Purchases selectedPurchase;
  MakePurchasePaymentView({
    Key? key,
    required this.selectedPurchase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MakePurchasePaymentViewModel>.reactive(
      viewModelBuilder: () =>
          MakePurchasePaymentViewModel(purchase: selectedPurchase),
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: [
              Text(
                "Purchase Payment",
                style: ktsHeaderText,
              ),
              verticalSpaceSmall,
              Text(
                "Pls fill the form to make payment to this purchase",
                style: ktsParagraphText,
              ),
              verticalSpaceSmall,
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Payment Description',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                keyboardType: TextInputType.name,
                controller: paymentDescriptionController,
              ),
              verticalSpaceSmall,
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Payment Reference',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                keyboardType: TextInputType.number,
                controller: paymentReferenceController,
              ),
              verticalSpaceSmall,
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Payment Total',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                keyboardType: TextInputType.number,
                controller: paymentTotalController,
              ),
              verticalSpaceSmall,
              TextFormField(
                controller: paymentTransactionDateController,
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
                    paymentTransactionDateController.text = formattedDate;
                  }
                },
              ),
              verticalSpaceLarge,
              GestureDetector(
                onTap: () async {
                  final DialogResponse? response = await model.dialogService
                      .showConfirmationDialog(
                          dialogPlatform: DialogPlatform.Cupertino,
                          title: 'Purchase Payment',
                          description:
                              'Are you sure you want to make payment to this purchase?',
                          barrierDismissible: true,
                          cancelTitle: 'Cancel',
                          confirmationTitle: 'Ok');
                  if (response?.confirmed == true) {
                    // Call the PurchasePayment function
                    bool paymentSuccessful =
                        await model.makePurchasePayment(model.purchase.id);
                    if (paymentSuccessful) {
                      // Payment was successful, handle further actions if needed
                      await model.dialogService.showDialog(
                          dialogPlatform: DialogPlatform.Cupertino,
                          title: 'Purchase Payment',
                          description:
                              'Payment successfully made to this purchase',
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
                          "Pay",
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
