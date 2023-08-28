import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/product&services_service.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

import './choose_item_view_model.dart';

class ChooseItemView extends StatefulWidget {
  const ChooseItemView({
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseItemView> createState() => _ChooseItemViewState();
}

class _ChooseItemViewState extends State<ChooseItemView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChooseItemViewModel>.reactive(
      viewModelBuilder: () => ChooseItemViewModel(),
      onModelReady: (model) async {
        // model.getProductOrServiceByBusiness;
        // model.addNewItem;
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: kcPrimaryColor,
          leading: IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kcTextColor,
            ),
            onPressed: model.navigateBack,
          ),
          title: const Text('Choose Item'),
          centerTitle: true,
          actions: [
            Row(
              children: [
                GestureDetector(
                  onTap: () =>
                      model.navigationService.navigateTo(Routes.addItemRoute),
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Text("New"),
                  ),
                ),
              ],
            )
          ],
          toolbarHeight: 80,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: (model.data == null)
                ? const Text('No Items')
                : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    primary: true,
                    shrinkWrap: true,
                    itemCount: model.data!.length,
                    itemBuilder: (context, index) {
                      return ItemsCard(
                        items: model.data![index],
                        isSelected:
                            model.selectedItems.contains(model.data![index]),
                        onSelected: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              model.selectedItems.add(model.data![index]);
                            } else {
                              model.selectedItems.remove(model.data![index]);
                            }
                          });
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return verticalSpaceTiny;
                    },
                  ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              if (model.selectedItems.isNotEmpty) {
                Navigator.of(context).pop(model.selectedItems);
              }
            },
            child: const Text('Add Selected Items'),
          ),
        ),
      ),
    );
  }
}

class ItemsCard extends StatelessWidget {
  const ItemsCard({
    Key? key,
    required this.items,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  final Items items;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: isSelected ? kcPrimaryColor : kcStrokeColor,
      title: Text(
        items.title,
        style: ktsBodyText,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      leading: Text(
        items.type,
        style: ktsBodyTextLight,
      ),
      trailing: Text(
        NumberFormat.currency(locale: 'en', symbol: '\N').format(items.price),
        style: ktsBodyText,
      ),
      onTap: () {
        onSelected(!isSelected);
      },
    );
  }
}
