import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/ui/add_purchase_order/add_purchase_order_view.form.dart';
import 'package:verzo_one/ui/create_merchant/create_merchant_view.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

import './add_purchase_order_view_model.dart';

@FormView(fields: [
  FormTextField(name: 'description'),
  FormTextField(name: 'reference'),
  FormTextField(name: 'transactionDate'),
  FormTextField(name: 'merchantId'),
])
class AddPurchaseOrderView extends StatelessWidget with $AddPurchaseOrderView {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPurchaseOrderViewModel>.reactive(
      viewModelBuilder: () => AddPurchaseOrderViewModel(),
      onModelReady: (AddPurchaseOrderViewModel model) async {
        model.getMerchantsByBusiness();
        model.addNewMerchant;
        listenToFormUpdated(model);
      },
      builder: (
        BuildContext context,
        AddPurchaseOrderViewModel model,
        Widget? child,
      ) {
        return Scaffold(
            body: AuthenticationLayout(
          busy: model.isBusy,
          onBackPressed: model.navigateBack,
          validationMessage: model.validationMessage,
          onMainButtonTapped: () => model.savePurchaseData(),
          title: 'Add Purchase Order',
          subtitle: 'Please fill the form below to create a purchase order',
          mainButtonTitle: 'Add',
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
                controller: descriptionController,
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
                controller: referenceController,
              ),
              verticalSpaceSmall,
              DropdownButtonFormField(
                decoration: InputDecoration(
                    labelText: ' Merchant',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder),
                items: model.merchantdropdownItems,
                value: merchantIdController.text.isEmpty
                    ? null
                    : merchantIdController.text,
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
                    merchantIdController.text = value.toString();
                  }
                },
              ),
              verticalSpaceSmall,
              TextFormField(
                controller: transactionDateController,
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
                    transactionDateController.text = formattedDate;
                  }
                },
              ),
              verticalSpaceSmall,
              verticalSpaceTiny,
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
                                model.newlySelectedPurchaseItems = await model
                                    .navigationService
                                    .navigateTo(Routes.choosePurchaseItemRoute);
                                // Receive the selected items from ChooseItemView
                                model.addselectedItems(
                                    model.newlySelectedPurchaseItems);
                              },
                            ),
                          ],
                        ),
                        verticalSpaceTiny,
                        if (model.selectedPurchaseItems.isNotEmpty)
                          ...model.selectedPurchaseItems.map((purchaseItem) =>
                              ListTile(
                                title: Text(purchaseItem.productName),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      NumberFormat.currency(
                                              locale: 'en', symbol: '\N')
                                          .format(purchaseItem.price),
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
                                        model.openEditBottomSheet(purchaseItem);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        model.removeSelectedItem(purchaseItem);
                                      },
                                    ),
                                  ],
                                ),
                              )),
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
        ));
      },
    );
  }
}
