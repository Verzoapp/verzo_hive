import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:verzo_one/app/app.locator.dart';
import 'package:verzo_one/app/app.router.dart';
import 'package:verzo_one/services/purchase_order_service.dart';
import 'package:verzo_one/ui/customers/customers_view.dart';
import 'package:verzo_one/ui/dashboard/dashboard_view.dart';
import 'package:verzo_one/ui/products_services/products_services_view.dart';
import 'package:verzo_one/ui/shared/styles.dart';
import 'package:verzo_one/ui/shared/ui_helpers.dart';

import './purchase_order_view_model.dart';

class PurchaseOrderView extends StatefulWidget {
  @override
  State<PurchaseOrderView> createState() => _PurchaseOrderViewState();
}

class _PurchaseOrderViewState extends State<PurchaseOrderView> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PurchaseOrderViewModel>.reactive(
      key: UniqueKey(),
      viewModelBuilder: () => PurchaseOrderViewModel(),
      onModelReady: (model) async {
        await model.getPurchaseByBusiness();
      },
      builder: (
        BuildContext context,
        PurchaseOrderViewModel model,
        Widget? child,
      ) {
        return Scaffold(
            key: globalKey,
            drawer: Drawer(
              elevation: 100,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: kcPrimaryColor,
                    ),
                    child: Column(
                      children: const [
                        CircleAvatar(
                          radius: 36,
                        ),
                        verticalSpaceTiny,
                        Text(
                          'Tam',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        // Text(
                        //   'mem4real@gmail.com',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 24,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.home,
                    ),
                    title: Text('Home'),
                    onTap: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const DashboardView(),
                    )),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.people,
                    ),
                    title: Text('Customers'),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CustomersView(),
                    )),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.people,
                    ),
                    title: Text('Purchases'),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PurchaseOrderView(),
                    )),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.assignment,
                    ),
                    title: Text('Products & Services'),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductsServicesView(),
                    )),
                  ),
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Profile'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                  ),
                ],
              ),
            ),
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
                                Icons.menu,
                                size: 32,
                              ),
                              color: kcButtonTextColor,
                              onPressed: () {
                                globalKey.currentState?.openDrawer();
                              },
                            ),
                            Text(
                              'Puchase Orders',
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
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 25, bottom: 50, left: 6, right: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 300,
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 60,
                                height: 22,
                                decoration: BoxDecoration(
                                    color: kcPrimaryColor.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(8)),
                                child: GestureDetector(
                                  onTap: () => model.navigationService
                                      .navigateTo(Routes.addPurchaseOrderRoute),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.add,
                                        size: 16,
                                        color: kcPrimaryColor,
                                      ),
                                      Text(
                                        "NEW",
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: kcPrimaryColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          verticalSpaceSmall,
                          Container(
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
                              child: Column(
                                children: [
                                  TextField(
                                    // controller: model.searchController,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(12),
                                      hintText: 'Search',
                                      hintStyle: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 16),
                                      prefixIcon: Icon(Icons.search,
                                          color: Colors.grey[600]),
                                      filled: true,
                                      fillColor: Colors.grey.withOpacity(0.7),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: kcPrimaryColor, width: 1),
                                      ),
                                    ),
                                  ),
                                  verticalSpaceTiny,
                                  Builder(builder: (context) {
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
                                      return const Text('No Purchase Orders');
                                    }
                                    return ListView.separated(
                                      padding: const EdgeInsets.all(12),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: model.data!.length,
                                      itemBuilder: (context, index) {
                                        var purchase = model.data![index];
                                        return PurchaseOrderCard(
                                          purchase: purchase,
                                          archivePurchase: () {
                                            model.archivePurchase(purchase.id);
                                          },
                                          deletePurchase: () {
                                            model.deletePurchase(purchase.id);
                                          },
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2),
                                          child: Divider(
                                            thickness: 0.4,
                                          ),
                                        );
                                      },
                                    );
                                  }),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}

class PurchaseOrderCard extends StatelessWidget {
  PurchaseOrderCard({
    Key? key,
    required this.purchase,
    required this.archivePurchase,
    required this.deletePurchase,
  }) : super(key: key);
  final navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final Purchases purchase;
  final Function archivePurchase;
  final Function deletePurchase;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        purchase.description,
        style: ktsBodyTextBoldOpaque,
      ),
      subtitle: Text(
        purchase.transactionDate,
        style: ktsBodyTextLight,
        // overflow: TextOverflow.values,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: (() {
              navigationService.navigateToUpdatePurchaseRoute(
                  selectedPurcahses: purchase);
            }),
          ),
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: (() {
              navigationService.navigateToViewPurchaseRoute(
                  selectedPurchase: purchase);
            }),
          ),
          IconButton(
              onPressed: () async {
                final DialogResponse? response =
                    await _dialogService.showConfirmationDialog(
                        dialogPlatform: DialogPlatform.Cupertino,
                        title: 'Archive Purchase',
                        description:
                            'Are you sure you want to archive this purchase?',
                        barrierDismissible: true,
                        cancelTitle: 'Cancel',
                        confirmationTitle: 'Ok');
                if (response?.confirmed == true) {
// Call the archivePurchase function
                  archivePurchase();
                }
              },
              icon: const Icon(
                Icons.archive,
                size: 24,
              )),
          IconButton(
              onPressed: () async {
                final DialogResponse? response =
                    await _dialogService.showConfirmationDialog(
                        dialogPlatform: DialogPlatform.Cupertino,
                        title: 'Delete Purchase',
                        description:
                            'Are you sure you want to delete this purchase?',
                        barrierDismissible: true,
                        cancelTitle: 'Cancel',
                        confirmationTitle: 'Ok');
                if (response?.confirmed == true) {
// Call the archivePurchase function
                  deletePurchase();
                }
              },
              icon: const Icon(
                Icons.delete,
                size: 24,
              )),
        ],
      ),
    );
  }
}
