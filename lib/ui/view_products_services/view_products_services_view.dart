import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:verzo_one/services/product&services_service.dart';
import 'package:verzo_one/ui/dumb_widgets/authentication_layout.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

import './view_products_services_view_model.dart';

class ViewProductsServicesView extends StatelessWidget {
  final Items selecteditem;

  const ViewProductsServicesView({Key? key, required this.selecteditem});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewProductsServicesViewModel>.reactive(
      viewModelBuilder: () => ViewProductsServicesViewModel(item: selecteditem),
      onModelReady: (model) async {},
      builder: (
        BuildContext context,
        ViewProductsServicesViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: AuthenticationLayout(
            busy: model.isBusy,
            onMainButtonTapped: model.navigateBack,
            title: 'View Products & Services',
            subtitle:
                'This information will be displayed publicly so be careful what you share.',
            mainButtonTitle: 'Done',
            form: Column(
              children: [
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: ktsFormText,
                    border: defaultFormBorder,
                  ),
                  initialValue: model.isProduct
                      ? model.item.productName
                      : model.item.serviceName,
                ),
                verticalSpaceSmall,
                TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder,
                    ),
                    initialValue: selecteditem.price.toString()),
                verticalSpaceSmall,
                if (model.isProduct) ...[
                  TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Basic Unit',
                        labelStyle: ktsFormText,
                        border: defaultFormBorder,
                      ),
                      initialValue: selecteditem.basicUnit.toString()),
                  verticalSpaceSmall,
                  // TextFormField(
                  //     readOnly: true,
                  //     decoration: InputDecoration(
                  //       labelText: 'Quantity in Stock',
                  //       labelStyle: ktsFormText,
                  //       border: defaultFormBorder,
                  //     ),
                  //     initialValue: selecteditem.quantityInStock.toString()),
                  // verticalSpaceSmall,
                ],
                TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Unit',
                      labelStyle: ktsFormText,
                      border: defaultFormBorder,
                    ),
                    initialValue: model.isProduct
                        ? selecteditem.productUnitName
                        : selecteditem.serviceUnitName),
              ],
            ),
          ),
        );
      },
    );
  }
}
