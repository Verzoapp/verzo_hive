// import 'package:pdf/pdf.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/services/purchase_order_service.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/make_purchase_payment/make_purchase_payment_view.dart';
import 'package:verzo_one/ui/mark_purchase_item_as_recieved/mark_purchase_item_as_recieved_view.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';
import 'package:verzo_one/ui/upload_merchant_invoice_to_purchase/upload_merchant_invoice_to_purchase_view.dart';

class ViewPurchaseViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final _purchaseService = locator<PurchaseService>();
  final DialogService dialogService = locator<DialogService>();

  late Purchases purchase; // Add selectedExpense variable

  // bool? recurringValue;

  ViewPurchaseViewModel({required this.purchase});
  void navigateBack() => navigationService.back();

  void secondaryButtonPressed() {
    showModalBottomSheet(
      context: navigationService.navigatorKey!.currentContext!,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(
              vertical: 16, horizontal: 16), // Adjust the padding
          width: double.infinity,
          height: 440,
          decoration: BoxDecoration(
            color: kcButtonTextColor,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12)), // Adjust the radius
            boxShadow: [
              BoxShadow(
                color: kcTextColorLight.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 2,
                // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Minimize the height
            children: [
              const Text('Select an action'),
              verticalSpaceSmall,
              Column(
                children: [
                  ListTile(
                    // leading: const CircleAvatar(
                    //   backgroundColor: kcPrimaryColor,
                    //   radius: 12,
                    // ),
                    leading: purchase.purchaseStatusId != 1
                        ? Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kcPrimaryColor, // Fill color
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 18,
                            ),
                          )
                        : null,
                    title: Text(
                      'Mark Purchase Items As Received',
                      style: TextStyle(
                        color: purchase.purchaseStatusId == 1
                            ? Colors.black
                            : Colors.grey, // Adjust colors
                      ),
                    ),
                    onTap: purchase.purchaseStatusId == 1
                        ? () {
                            // Handle the action
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return MarkPurchaseItemAsRecievedView(
                                    selectedPurchase: purchase);
                              },
                            ).whenComplete(() async {});
                          }
                        : null,
                  ),
                  const Divider(),
                  ListTile(
                    // leading: const CircleAvatar(
                    //   backgroundColor: kcPrimaryColor,
                    //   radius: 12,
                    // ),
                    leading: purchase.purchaseStatusId != 1
                        ? Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kcPrimaryColor, // Fill color
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 18,
                            ),
                          )
                        : null,
                    title: Text(
                      'Add Merchant Invoice',
                      style: TextStyle(
                        color: purchase.purchaseStatusId == 2
                            ? Colors.black
                            : Colors.grey, // Adjust colors
                      ),
                    ),
                    onTap: purchase.purchaseStatusId == 2
                        ? () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return UploadMerchantInvoiceToPurchaseView(
                                    selectedPurchase: purchase);
                              },
                            ).whenComplete(() async {
                              // await model
                              //     .getCustomersByBusiness(); // reset the `_isCreatingMerchant` flag when the bottom sheet is closed
                            });
                          }
                        : null,
                  ),
                  const Divider(),
                  ListTile(
                      leading: purchase.purchaseStatusId != 3
                          ? Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kcPrimaryColor, // Fill color
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 18,
                              ),
                            )
                          : Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kcPrimaryColor, // Fill color
                              ),
                            ),
                      title: Text(
                        'Add Payment',
                        style: TextStyle(
                          color: purchase.purchaseStatusId == 3
                              ? Colors.black
                              : Colors.grey, // Adjust colors
                        ),
                      ),
                      onTap: purchase.purchaseStatusId == 3
                          ? () {
                              // Handle the action
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return MakePurchasePaymentView(
                                      selectedPurchase: purchase);
                                },
                              ).whenComplete(() async {
                                // await model
                                //     .getCustomersByBusiness(); // reset the `_isCreatingMerchant` flag when the bottom sheet is closed
                              });
                            }
                          : null),
                  const Divider(),
                  ListTile(
                    title: const Text('Send Purchase'),
                    onTap: () async {
                      final DialogResponse? response =
                          await dialogService.showConfirmationDialog(
                              dialogPlatform: DialogPlatform.Cupertino,
                              title: 'Send Purchase',
                              description:
                                  'Are you sure you want to send this Purchase?',
                              barrierDismissible: true,
                              cancelTitle: 'Cancel',
                              confirmationTitle: 'Ok');
                      if (response?.confirmed == true) {
                        // Call the PurchasePayment function

                        bool purchaseSent = await sendPurchase(purchase.id);
                        if (purchaseSent) {
                          // Payment was successful, handle further actions if needed
                          await dialogService.showDialog(
                              dialogPlatform: DialogPlatform.Cupertino,
                              title: 'Send Purchase',
                              description:
                                  'Purchase has been sent successfully',
                              barrierDismissible: true,
                              buttonTitle: 'OK');
                        }
                      }
                    },
                  ),
                ],
              ),
              verticalSpaceSmall,
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: defaultBorderRadius,
                      color: kcButtonTextColor,
                      border: Border.all(
                          color: kcPrimaryColor.withOpacity(0.6), width: 1)),
                  child: Text(
                    'Cancel',
                    style: ktsButtonTextBlue,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> sendPurchase(String purchaseId) async {
    final bool purchaseSent =
        await _purchaseService.sendPurchase(purchaseId: purchaseId, copy: true);

    return purchaseSent;
  }

  // Function to create the printout view
  Widget buildPrintableView() {
    // final SharedPreferences prefs = awaitSharedPreferences.getInstance();
    // String businessName = prefs.getString('businessName') ?? '';
    // String businessEmail = prefs.getString('businessEmail') ?? '';
    // String businessMobile = prefs.getString('businessMobile') ?? '';
    return Column(
      children: [
        Row(
          children: [Text('')],
        ),
        Center(
          child: Text(
            'PURCHASE',
            style: ktsHeaderText,
          ),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text('DESCRIPTION'),
                verticalSpaceTiny,
                Text(purchase.description)
              ],
            ),
            Column(
              children: [
                Text('REFERENCE'),
                verticalSpaceTiny,
                Text(purchase.reference ?? '')
              ],
            ),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text('MERCHANT NAME'),
                verticalSpaceTiny,
                Text(purchase.merchantName)
              ],
            ),
            Column(
              children: [
                Text('TRANSACTION DATE'),
                verticalSpaceTiny,
                Text(purchase.transactionDate)
              ],
            ),
          ],
        ),
        verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text('MERCHANT EMAIL'),
                verticalSpaceTiny,
                Text(purchase.merchantEmail)
              ],
            ),
            // Column(
            //   children: [
            //     Text('TRANSACTION DATE'),
            //     verticalSpaceTiny,
            //     Text(purchase.transactionDate)
            //   ],
            // ),
          ],
        ),
        Divider(),
        Table(
          border: TableBorder.all(),
          children: [
            TableRow(children: [
              TableCell(child: Text('S/N')),
              TableCell(child: Text('Item Name')),
              TableCell(child: Text('Unit Price')),
              TableCell(child: Text('Quantity')),
            ]),
            // Loop through your purchase items data and add TableRow for each item
            for (var item in purchase.purchaseItems)
              TableRow(children: [
                TableCell(child: Text(item.index.toString())),
                TableCell(child: Text(item.itemDescription)),
                TableCell(child: Text(item.unitPrice.toString())),
                TableCell(child: Text(item.quantity.toString())),
              ]),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Total',
              style: ktsHeaderText,
            ),
            horizontalSpaceTiny,
            Text(
              purchase.total.toString(),
              style: ktsHeaderText,
            )
          ],
        )
      ],
      // Create your printout-style content here
    );
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
