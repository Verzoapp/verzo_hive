import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:verzo_one/ui/add_item/add_item_view.form.dart';
import 'package:verzo_one/ui/add_item/add_item_view_model.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

@FormView(fields: [
  FormTextField(name: 'productName'),
  FormTextField(name: 'price'),
  FormTextField(name: 'basicUnit'),
  FormTextField(name: 'quantityInStock'),
])
class AddItemView extends StatelessWidget with $AddItemView {
  AddItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddItemViewModel>.reactive(
      viewModelBuilder: () => AddItemViewModel(),
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: kcPrimaryColor,
          leading: IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            icon: const Icon(
              Icons.close,
              color: kcTextColor,
              size: 32,
            ),
            onPressed: model.navigateBack,
          ),
          title: const Text('Add Item'),
          centerTitle: true,
          toolbarHeight: 80,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(children: [
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
                        model.isProduct ? kcPrimaryColor : Colors.grey,
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
                        !model.isProduct ? kcPrimaryColor : Colors.grey,
                  ),
                  child: const Text('Service'),
                ),
              ],
            ),
            verticalSpaceSmall,
            if (model.isProduct) ...[
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'name',
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
            ] else ...[
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'name',
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
            ],
            verticalSpaceMedium,
            GestureDetector(
              onTap: model.isProduct
                  ? model.saveProductData
                  : model.saveServiceData,
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
                        "Save",
                        style: ktsButtonText,
                      ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
