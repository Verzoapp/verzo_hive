import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/ui/add_products_services/add_products_services_view.form.dart';

import './add_products_services_view_model.dart';

import 'package:stacked/stacked_annotations.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/setup_bottom_sheet_ui.dart';

import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

@FormView(fields: [
  FormTextField(name: 'productName'),
  FormTextField(name: 'price'),
  FormTextField(name: 'basicUnit'),
  FormTextField(name: 'quantityInStock'),
  FormTextField(name: 'productUnitId'),
  FormTextField(name: 'serviceUnitId'),
])
class AddProductsServicesView extends StatelessWidget
    with $AddProductsServicesView {
  AddProductsServicesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddProductsServicesViewModel>.reactive(
      viewModelBuilder: () => AddProductsServicesViewModel(),
      onModelReady: (model) async {
        await model.getProductUnits();
        model.getServiceUnits();
        listenToFormUpdated(model);
      },
      builder: (context, model, child) => Scaffold(
        body: AuthenticationLayout(
          busy: model.isBusy,
          validationMessage: model.validationMessage,
          onBackPressed: model.navigateBack,
          onMainButtonTapped: () => model.isProduct
              ? model.saveProductData()
              : model.saveServiceData(),
          title: 'Add Products & Services',
          subtitle: 'Please fill the form below to create a product or service',
          mainButtonTitle: 'Add',
          form: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      model.isProduct = true;
                      model.notifyListeners(); // force a redraw
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          model.isProduct ? kcPrimaryColor : kcStrokeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          bottomLeft: Radius.circular(12.0),
                        ),
                      ),
                    ),
                    child: const Text('Product'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      model.isProduct = false;
                      model.notifyListeners(); // force a redraw
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          !model.isProduct ? kcPrimaryColor : kcStrokeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                    ),
                    child: const Text('Service'),
                  ),
                ],
              ),
              verticalSpaceSmall,
              if (model.isProduct) ...[
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
                      labelText: 'Quantity in stock',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  keyboardType: TextInputType.name,
                  controller: quantityInStockController,
                ),
                verticalSpaceSmall,
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: 'Unit',
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
              ] else ...[
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
                  keyboardType: TextInputType.name,
                  controller: priceController,
                ),
                verticalSpaceSmall,
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: 'Unit',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder),
                  items: model.serviceUnitdropdownItems,
                  value: serviceUnitIdController.text.isEmpty
                      ? null
                      : serviceUnitIdController.text,
                  onChanged: (value) {
                    serviceUnitIdController.text = value.toString();
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
