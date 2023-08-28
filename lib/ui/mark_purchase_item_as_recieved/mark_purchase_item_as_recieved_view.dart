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
import 'package:verzo_one/ui/mark_purchase_item_as_recieved/mark_purchase_item_as_recieved_view.form.dart';
import 'package:verzo_one/ui/mark_purchase_item_as_recieved/mark_purchase_item_as_recieved_view_model.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

@FormView(fields: [
  FormTextField(name: 'quantityReceived'),
  FormTextField(name: 'dateReceived'),
])
class MarkPurchaseItemAsRecievedView extends StatelessWidget
    with $MarkPurchaseItemAsRecievedView {
  final Purchases selectedPurchase;
  MarkPurchaseItemAsRecievedView({
    Key? key,
    required this.selectedPurchase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MarkPurchaseItemAsRecievedViewModel>.reactive(
      viewModelBuilder: () =>
          MarkPurchaseItemAsRecievedViewModel(purchase: selectedPurchase),
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: [
              Text(
                "Mark Items As Recieved",
                style: ktsHeaderText,
              ),
              verticalSpaceSmall,
              // Text(
              //   "Pls fill the form to make payment to this purchase",
              //   style: ktsParagraphText,
              // ),
              const Text(
                "MERCHANT NAME",
              ),
              Text(selectedPurchase
                  .merchantName), // Replace with actual merchant name
              verticalSpaceSmall,
              const Text(
                "MERCHANT EMAIL",
              ),
              Text(selectedPurchase.merchantEmail),
              verticalSpaceSmall,
              // const Text(
              //   "DATE RECEIVED",
              // ),
              // verticalSpaceSmall,
              // InkWell(
              //   onTap: () async {
              //     DateTime? pickedDate = await showDatePicker(
              //       context: context,
              //       initialDate: DateTime.now(),
              //       firstDate: DateTime(DateTime.now().year - 5),
              //       lastDate: DateTime(DateTime.now().year + 5),
              //     );
              //     if (pickedDate != null) {
              //       String formattedDate =
              //           DateFormat('yyyy-MM-dd').format(pickedDate);
              //       dateReceivedController.text = formattedDate;
              //     }
              //   },
              //   child: Container(
              //     decoration: BoxDecoration(
              //       border: Border.all(color: Colors.grey),
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //     padding: EdgeInsets.all(8),
              //     child: Text(
              //       'formattedDate,',
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),
              verticalSpaceSmall,
              TextFormField(
                controller: dateReceivedController,
                decoration: InputDecoration(
                    labelText: 'Date Received',
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
                    dateReceivedController.text = formattedDate;
                  }
                },
              ),
              verticalSpaceSmall,

              ListView.separated(
                shrinkWrap: true,
                itemCount: selectedPurchase.purchaseItems.length,
                itemBuilder: (context, index) {
                  final purchaseItem = selectedPurchase.purchaseItems[index];
                  bool itemsCompletelyReceived =
                      purchaseItem.quantity == purchaseItem.quantityRecieved;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Item name: ${purchaseItem.itemDescription}"),
                      Text("Price: ${purchaseItem.unitPrice}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Quantity ordered: ${purchaseItem.quantity}"),
                          Row(
                            children: [
                              Text("Quantity received:"),
                            ],
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: quantityReceivedController,
                      ),
                      verticalSpaceTiny,
                      if (purchaseItem.quantity ==
                          purchaseItem.quantityRecieved)
                        Row(
                          children: const [
                            Checkbox(
                              value: true,
                              onChanged:
                                  null, // To prevent changing the checkbox state
                            ),
                            Text('Items completely received'),
                          ],
                        ),
                      if (purchaseItem.quantity !=
                          purchaseItem.quantityRecieved)
                        GestureDetector(
                          onTap: () async {
                            final DialogResponse? response = await model
                                .dialogService
                                .showConfirmationDialog(
                                    dialogPlatform: DialogPlatform.Cupertino,
                                    title: 'Mark items as received',
                                    description:
                                        'Are you sure you want to mark this item as received?',
                                    barrierDismissible: true,
                                    cancelTitle: 'Cancel',
                                    confirmationTitle: 'Ok');
                            if (response?.confirmed == true) {
                              PurchaseItemDetail purchaseItem =
                                  selectedPurchase.purchaseItems[index];
                              // Call the PurchasePayment function

                              bool markItemSuccessful = await model
                                  .markPurchaseItemAsRecieved(purchaseItem.id);
                              if (markItemSuccessful) {
                                // Payment was successful, handle further actions if needed
                                await model.dialogService.showDialog(
                                    dialogPlatform: DialogPlatform.Cupertino,
                                    title: 'Mark items as received',
                                    description:
                                        'Item has been successfully received',
                                    barrierDismissible: true,
                                    buttonTitle: 'OK');

                                if (purchaseItem.quantity ==
                                    purchaseItem.quantityRecieved) {
                                  Row(
                                    children: const [
                                      Checkbox(
                                        value: true,
                                        onChanged:
                                            null, // To prevent changing the checkbox state
                                      ),
                                      Text('Items completely received'),
                                    ],
                                  );
                                }

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
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  )
                                : Text(
                                    "Save Item As Received",
                                    style: ktsButtonText,
                                  ),
                          ),
                        ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Column(
                    children: const [
                      verticalSpaceTiny,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Divider(
                          thickness: 0.4,
                        ),
                      ),
                    ],
                  );
                },
              ),
              verticalSpaceSmall,
            ],
          ),
        ),
      ),
    );
  }
}
