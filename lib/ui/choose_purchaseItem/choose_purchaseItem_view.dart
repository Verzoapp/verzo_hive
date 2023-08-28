import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/product&services_service.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

import 'choose_purchaseItem_view_model.dart';

class ChoosePurchaseItemView extends StatefulWidget {
  const ChoosePurchaseItemView({
    Key? key,
  }) : super(key: key);

  @override
  State<ChoosePurchaseItemView> createState() => _ChoosePurchaseItemViewState();
}

class _ChoosePurchaseItemViewState extends State<ChoosePurchaseItemView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChoosePurchaseItemViewModel>.reactive(
      viewModelBuilder: () => ChoosePurchaseItemViewModel(),
      onModelReady: (model) async {
        // model.getProductOrServiceByBusiness;
        // model.addNewItem;
      },
      builder: (context, model, child) => Scaffold(
        // appBar: AppBar(
        //   backgroundColor: kcPrimaryColor,
        //   // leading: IconButton(
        //   //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   //   alignment: Alignment.centerLeft,
        //   //   icon: const Icon(
        //   //     Icons.arrow_back_ios,
        //   //     color: kcTextColor,
        //   //   ),
        //   //   onPressed: model.navigateBack,
        //   // ),
        //   title: const Text('Choose Purchase Item'),
        //   centerTitle: true,
        //   actions: [
        //     Row(
        //       children: [
        //         GestureDetector(
        //           onTap: () => model.navigationService
        //               .navigateTo(Routes.addPurchaseItemRoute),
        //           child: const Padding(
        //             padding: EdgeInsets.only(right: 16.0),
        //             child: Text("New"),
        //           ),
        //         ),
        //       ],
        //     )
        //   ],
        //   toolbarHeight: 80,
        // ),
        body: Column(
          children: [
            Container(
              height: 130,
              color: kcPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  children: [
                    verticalSpaceMedium,
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 32,
                          ),
                          color: kcButtonTextColor,
                          onPressed: () {
                            Navigator.of(context)
                                .pop(model.selectedPurchaseItems);
                          },
                        ),
                        Text(
                          'Choose Purchase Item',
                          style: ktsHeaderTextWhite,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                primary: false,
                scrollDirection: Axis.vertical,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kcButtonTextColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: kcTextColorLight.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 0,
                        // changes position of shadow
                      ),
                    ],
                  ),
                  child: Builder(builder: (context) {
                    if (model.isBusy) {
                      return Column(children: const [
                        verticalSpaceLarge,
                        CircularProgressIndicator(
                          color: kcPrimaryColor,
                        ),
                        verticalSpaceLarge
                      ]);
                    }
                    if (model.data == null) {
                      return const Text('No Purchase Items');
                    }
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      primary: true,
                      shrinkWrap: true,
                      itemCount: model.data!.length,
                      itemBuilder: (context, index) {
                        return PurchaseItemsCard(
                          purchaseItems: model.data![index],
                          isSelected: model.selectedPurchaseItems
                              .contains(model.data![index]),
                          onSelected: (isSelected) {
                            setState(() {
                              if (isSelected) {
                                model.selectedPurchaseItems
                                    .add(model.data![index]);
                              } else {
                                model.selectedPurchaseItems
                                    .remove(model.data![index]);
                              }
                            });
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return verticalSpaceTiny;
                      },
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // if (model.selectedPurchaseItems.isNotEmpty) {
              Navigator.of(context).pop(model.selectedPurchaseItems);
              // }
            },
            child: const Text('Add Selected Purchase Items'),
          ),
        ),
      ),
    );
  }
}

class PurchaseItemsCard extends StatelessWidget {
  const PurchaseItemsCard({
    Key? key,
    required this.purchaseItems,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  final Products purchaseItems;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: isSelected ? kcPrimaryColor : kcStrokeColor,
      title: Text(
        purchaseItems.productName,
        style: ktsBodyText,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      leading: Text(
        purchaseItems.quantity.toString(),
        style: ktsBodyTextLight,
      ),
      trailing: Text(
        NumberFormat.currency(locale: 'en', symbol: '\N')
            .format(purchaseItems.price),
        style: ktsBodyText,
      ),
      onTap: () {
        onSelected(!isSelected);
      },
    );
  }
}
