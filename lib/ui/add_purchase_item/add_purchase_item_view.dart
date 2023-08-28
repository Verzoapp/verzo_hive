import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:verzo_one/ui/add_purchase_item/add_purchase_item_view.form.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

import './add_purchase_item_view_model.dart';

@FormView(fields: [
  FormTextField(name: 'productName'),
  FormTextField(name: 'price'),
  FormTextField(name: 'basicUnit'),
  FormTextField(name: 'quantityInStock'),
  FormTextField(name: 'productUnitId'),
])
class AddPurchaseItemView extends StatelessWidget with $AddPurchaseItemView {
  AddPurchaseItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPurchaseItemViewModel>.reactive(
      viewModelBuilder: () => AddPurchaseItemViewModel(),
      onModelReady: (AddPurchaseItemViewModel model) async {
        await model.getProductUnits();
        listenToFormUpdated(model);
      },
      builder: (
        BuildContext context,
        AddPurchaseItemViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: AuthenticationLayout(
            busy: model.isBusy,
            validationMessage: model.validationMessage,
            onBackPressed: model.navigateBack,
            onMainButtonTapped: () => model.saveProductData(),
            title: 'Add Products (Purchase Items)',
            subtitle:
                'Please fill the form below to create a product (purchase item)',
            mainButtonTitle: 'Add',
            form: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  keyboardType: TextInputType.name,
                  controller: productNameController,
                ),
                verticalSpaceSmall,
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Price',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  keyboardType: TextInputType.number,
                  controller: priceController,
                ),
                verticalSpaceSmall,
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Basic unit',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  keyboardType: TextInputType.number,
                  controller: basicUnitController,
                ),
                verticalSpaceSmall,
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Quantity in stock (Optional)',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  keyboardType: TextInputType.name,
                  controller: quantityInStockController,
                ),
                verticalSpaceSmall,
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: 'Product Unit',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  items: model.productUnitdropdownItems,
                  value: productUnitIdController.text.isEmpty
                      ? null
                      : productUnitIdController.text,
                  onChanged: (value) {
                    productUnitIdController.text = value.toString();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
