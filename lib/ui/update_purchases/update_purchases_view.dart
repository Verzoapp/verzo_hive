import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/invoices_service.dart';
import 'package:verzo_one/services/purchase_order_service.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_view.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

import 'update_purchases_view_model.dart';

class UpdatePurchasesView extends StatelessWidget {
  final Purchases selectedPurcahses;
  UpdatePurchasesView({
    Key? key,
    required this.selectedPurcahses,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdatePurchasesViewModel>.reactive(
      viewModelBuilder: () =>
          UpdatePurchasesViewModel(purchase: selectedPurcahses),
      onModelReady: (UpdatePurchasesViewModel model) async {
        await model.getMerchantsByBusiness();
        model.addNewMerchant;
        model.setSelectedPurchase();
        await model.getMerchantsByBusiness();
        model.addNewMerchant;
      },
      builder: (
        BuildContext context,
        UpdatePurchasesViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: AuthenticationLayout(
            busy: model.isBusy,
            onBackPressed: model.navigateBack,
            validationMessage: model.validationMessage,
            onMainButtonTapped: model.updatePurchaseData,
            title: 'Update Purchase Order',
            subtitle: 'Make changes to this purchase order',
            mainButtonTitle: 'Save',
            form: Column(
              children: [
                TextFormField(
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  maxLines: 3,
                  decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  keyboardType: TextInputType.name,
                  controller: model.updateDescriptionController,
                ),
                verticalSpaceSmall,
                TextFormField(
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  maxLines: 3,
                  decoration: InputDecoration(
                      labelText: 'Reference (Optional)',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  keyboardType: TextInputType.name,
                  controller: model.updateReferenceController,
                ),
                verticalSpaceSmall,
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: ' Merchant',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  items: model.merchantdropdownItems,
                  value: model.updateMerchantIdController.text.isEmpty
                      ? null
                      : model.updateMerchantIdController.text,
                  onChanged: (value) async {
                    if (value == 'new_category') {
                      await showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return CreateMerchantView();
                        },
                      ).whenComplete(() async {
                        await model.getMerchantsByBusiness();

                        // reset the `_isCreatingMerchant` flag when the bottom sheet is closed
                      });
                    } else {
                      model.updateMerchantIdController.text = value.toString();
                    }
                  },
                ),
                verticalSpaceSmall,
                TextFormField(
                  controller: model.updateTransactionDateController,
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
                      model.updateTransactionDateController.text =
                          formattedDate;
                    }
                  },
                ),
                verticalSpaceSmall,
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Purchase Items',
                                style: ktsBodyTextBold,
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () async {
                                  model.newlySelectedPurchaseItems =
                                      await model.navigationService.navigateTo(
                                          Routes.choosePurchaseItemRoute);

                                  // Receive the selected items from ChooseItemView
                                  model.addselectedItems(model
                                      .convertProductsToPurchaseItemDetails(
                                          model.newlySelectedPurchaseItems));
                                },
                              ),
                            ],
                          ),
                          verticalSpaceTiny,
                          if (model.selectedItems.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: model.selectedItems.length,
                              itemBuilder: (context, index) {
                                final purchaseItem = model.selectedItems[index];

                                return ListTile(
                                  title: Text(purchaseItem.itemDescription),
                                  // ... display other purchase item details ...
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        NumberFormat.currency(
                                                locale: 'en', symbol: '\N')
                                            .format(purchaseItem.unitPrice),
                                        style: ktsBodyText,
                                      ),
                                      horizontalSpaceSmall,
                                      Text('Qty: ${purchaseItem.quantity}'),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          // Edit purchase item logic
                                          model.openEditBottomSheet(
                                              purchaseItem);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          model
                                              .removeSelectedItem(purchaseItem);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          // if (model.selectedPurchaseItems.isNotEmpty)
                          //   ...model.selectedPurchaseItems
                          //       .map((purchaseItem) => ListTile(
                          //             title: Text(purchaseItem.itemDescription),
                          //             subtitle: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.start,
                          //               children: [
                          //                 Text(
                          //                   NumberFormat.currency(
                          //                           locale: 'en', symbol: '\N')
                          //                       .format(purchaseItem.unitPrice),
                          //                   style: ktsBodyText,
                          //                 ),
                          //                 horizontalSpaceSmall,
                          //                 Text('Qty: ${purchaseItem.quantity}'),
                          //               ],
                          //             ),
                          //             trailing: Row(
                          //               mainAxisSize: MainAxisSize.min,
                          //               children: [
                          //                 IconButton(
                          //                   icon: const Icon(Icons.edit),
                          //                   onPressed: () {
                          //                     model.editSelectedItem;
                          //                     // model.openEditBottomSheet(
                          //                     //     purchaseItem);
                          //                   },
                          //                 ),
                          //                 IconButton(
                          //                   icon: const Icon(Icons.delete),
                          //                   onPressed: () {
                          //                     model.removeSelectedItem(
                          //                         purchaseItem);
                          //                   },
                          //                 ),
                          //               ],
                          //             ),
                          //           )),
                          verticalSpaceTiny,
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'TOTAL',
                                style: ktsBodyTextBold,
                              ),
                              Text(
                                'N${model.total.toStringAsFixed(2)}',
                                style: ktsBodyTextBold,
                              ),
                            ],
                          ),
                          verticalSpaceTiny
                        ]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
