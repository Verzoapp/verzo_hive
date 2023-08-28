import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/services/product&services_service.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

import './update_products_services_view_model.dart';

class UpdateProductsServicesView extends StatelessWidget {
  final Items selectedItem;
  const UpdateProductsServicesView({Key? key, required this.selectedItem});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateProductsServicesViewModel>.reactive(
      viewModelBuilder: () =>
          UpdateProductsServicesViewModel(item: selectedItem),
      onModelReady: (UpdateProductsServicesViewModel model) async {
        await model.getProductUnits();
        await model.getServiceUnits();
        model.setSelectedItem();
      },
      builder: (
        BuildContext context,
        UpdateProductsServicesViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: AuthenticationLayout(
            onBackPressed: model.navigateBack,
            busy: model.isBusy,
            onMainButtonTapped: model.isProduct
                ? model.updateProductData
                : model.updateServiceData,
            title: 'Update Products & Services',
            subtitle: 'Make changes to this product or service.',
            mainButtonTitle: 'Save',
            form: Column(
              children: [
                TextFormField(
                  controller: model.updateNameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder,
                  ),
                ),
                verticalSpaceSmall,
                TextFormField(
                  controller: model.updatePriceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder,
                  ),
                ),
                verticalSpaceSmall,
                if (model.isProduct) ...[
                  TextFormField(
                    controller: model.updateBasicUnitController,
                    decoration: InputDecoration(
                      labelText: 'Basic Unit',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder,
                    ),
                  ),
                  verticalSpaceSmall,
                  // TextFormField(
                  //   controller: model.updateQuantityInStockController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Quantity in Stock',
                  //     labelStyle: ktsFormText,
                  //     border: defaultFormBorder,
                  //   ),
                  // ),
                  // verticalSpaceSmall,
                ],
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Unit',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder,
                  ),
                  items: model.isProduct
                      ? model.productUnitdropdownItems
                      : model.serviceUnitdropdownItems,
                  value: model.isProduct
                      ? model.updateProductUnitIdController?.text
                      : model.updateServiceUnitIdController?.text,
                  onChanged: (value) {
                    model.isProduct
                        ? model.updateProductUnitIdController?.text =
                            value.toString()
                        : model.updateServiceUnitIdController?.text =
                            value.toString();
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
